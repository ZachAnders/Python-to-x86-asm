from ..debug import dbg
from .base import AbstractOperation, BasicOperation
from .helpers import call_func_asm, CONST

class OpAdd(AbstractOperation):
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = True
    def __init__(self, mem, left, right):
        self.mem = mem
        self.left = left
        self.right = right

        self.output_key = self.mem.allocate(spillable=True)
        self.temp_reg = self.mem.allocate(spillable=False)
        assert not self.temp_reg.canSpill()

    def write(self):
        dbg.log(self.left)
        left = self.mem.get(self.left)
        right = self.mem.get(self.right)

        output = self.mem.get(self.output_key)
        temp_reg = self.mem.get(self.temp_reg)

        load_left = self.mem.doLoad(left, temp_reg)
        save_result = self.mem.doLoad(temp_reg, output)

        assert not self.temp_reg.canSpill()

        return """
            {load_left}
            addl {right_operand}, {temp_reg} # Add right operand to left
            {save_result}
        """.format(
            load_left=load_left.write(),
            temp_reg=temp_reg,
            right_operand=right,
            save_result=save_result.write())
            
    def get_memory_operands(self):
        return [
                ([self.left], [self.temp_reg]),
                ([self.right, self.temp_reg], [self.temp_reg]),
                ([self.temp_reg], [self.output_key]),
                ]


class OpUnarySub(BasicOperation):
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = True
    def write(self):
        node = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)
        temp_reg = self.mem.get(self.temp_reg)

        load_op = self.mem.doLoad(node, temp_reg)
        save_op = self.mem.doLoad(temp_reg, output)

        return """
            {load} # Load Unary Sub operand
            negl {output} # Neg operand
            {save} # Save Unary Sub result
        """.format(
            load=load_op.write().strip(),
            save=save_op.write().strip(),
            output=temp_reg)

    def get_memory_operands(self):
        return [
                ([self.args[0]], [self.temp_reg]),
                ([self.temp_reg], [self.temp_reg]),
                ([self.temp_reg], [self.output_key]),
                ]

class OpPrintnl(BasicOperation):
    HAS_OUTPUT_KEY = False
    def write(self):
        left = self.mem.get(self.args[0])
        #print_func = 'print_int_nl'

        #return call_func_asm(print_func, arguments=[left])
        return call_func_asm('print_any', arguments=[left])

class OpCallFunc(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        fname = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)

        return call_func_asm(fname, output=output)

class OpAssign(AbstractOperation):
    def __init__(self, mem, name, value_ref):
        self.mem = mem
        self.name = name
        self.value_ref = value_ref

        # Allocate space for this variable
        self.alloc_var = self.mem.allocate(self.name)

        self.temp_register = self.mem.allocate(spillable=False)

    def write(self):
        # Get the register with the result in it
        source = self.mem.get(self.value_ref)
        temp = self.mem.get(self.temp_register)
        output = self.mem.get(self.alloc_var)
        load_op_tmp = self.mem.doLoad(source, temp)
        load_op_dest = self.mem.doLoad(temp, output)

        return """
            {load_tmp}
            {load_op_dest}
        """ .format(
            load_tmp=load_op_tmp.write(),
            load_op_dest=load_op_dest.write())
    def get_memory_operands(self):
        return [
                ([self.value_ref], [self.temp_register]),
                ([self.temp_register], [self.alloc_var])
                ]

class OpBoolSetCondition(BasicOperation):
    # TODO: Liveness?
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = True
    def write(self):
        false_label = self.args[2]
        end_label = self.args[3]

        output = self.mem.get(self.output_key)
        tmp_reg = self.mem.get(self.temp_reg)
        left = self.mem.get(self.args[0])
        right = self.mem.get(self.args[1])
        
        return """
        movl {right}, {output}
        jmp {end_label}

        {false_label}:
        movl {left}, {tmp_reg}
        movl {tmp_reg}, {output}
        jmp {end_label}

        {end_label}:
        """.format(
                false_label=false_label,
                end_label=end_label,
                output=output,
                tmp_reg=tmp_reg,
                right=right,
                left=left
                )

class OpJumpOnBool(AbstractOperation):
    # TODO: Liveness?
    HAS_OUTPUT_KEY = False
    def __init__(self, mem, condition, label, boolean=True):
        self.mem = mem
        self.condition = condition
        self.label = label
        self.boolean = int(boolean)
        
    def write(self):
        cond_alloc = self.mem.get(self.condition)

        func = call_func_asm('is_true',
                arguments=[cond_alloc])
        return """
            {func}
            cmpl ${value}, %eax
            je {label}
        """.format(func=func,
                label=self.label,
                value=self.boolean)


class OpNewConst(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        output_alloc = self.mem.get(self.output_key)
        return """
        movl ${value}, {dest} # Allocate new constant
        {inject}
        """.format(
            value=self.args[0],
            dest=self.mem.get(self.output_key),
            inject=output_alloc.inject('INT'),
            )

class OpLabel(AbstractOperation):
    def __init__(self, label_name):
        self.label = label_name
    def write(self):
        return "." + self.label

class OpList(AbstractOperation):
    def __init__(self, mem, nodes):
        self.mem = mem
        self.output_key = self.mem.allocate(spillable=True)
        self.temp_var = self.mem.allocate(spillable=True)

    # TODO: Liveness?
    def add_elem(self, idx, elem_ref):
        elem_alloc = self.mem.get(elem_ref)
        out_alloc = self.mem.get(self.output_key)

        append = call_func_asm('set_subscript', [out_alloc, CONST(idx), elem_alloc])

        return append

    def write(self):
        output_alloc = self.mem.get(self.output_key)
        elems = self.args[0]

        mk_list = call_func_asm('create_list', [CONST(len(elems))], output_alloc)
        elem_code = ""
        for idx, ref in enumerate(elems):
            elem_code += self.add_elem(idx, ref)

        return """
        {mk_list}
        {elem_code}
        """.format(
                mk_list=mk_list,
                elem_code=elem_code)

    def get_memory_operands(self):
        return [
                (self.args[0], [self.output_key]),
                (self.args[0]+[self.output_key], [self.output_key])
                ]

class OpStmt(BasicOperation):
    def write(self):
        return """
        pushl %ebp
        movl %esp, %ebp
        {allocate_stack} # Allocate stack
        """.format(
            allocate_stack=self.mem.getStackAllocation().write())

class OpModule(BasicOperation):
    def write(self):
        return """
        .global main
        main:
        """

class OpReturn(BasicOperation):
    def write(self):
        return """
        movl $0, %eax # Zero eax return code
        leave
        ret
        """
