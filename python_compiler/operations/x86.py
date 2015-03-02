from ..debug import dbg
from .base import AbstractOperation, BasicOperation
from .helpers import LabelManager
from .helpers import call_func_asm, CONST

class OpAdd(AbstractOperation):
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = True
    def __init__(self, mem, left, right, is_int=True, output_key=None):
        self.mem = mem
        self.left = left
        self.right = right
        self.is_int = is_int

        if output_key == None:
            self.output_key = self.mem.allocate(spillable=True)
        else:
            self.output_key = output_key

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

        if self.is_int:
            #proj_temp = temp_reg.project('INT', force=True)
            #proj_right = right.project('INT', force=True)
            add_code = """
                pushl {right_operand}
                sarl $2, {temp_reg}
                sarl $2, {right_operand}
                addl {right_operand}, {temp_reg}
                popl {right_operand}
                {inject_result}
            """.format(right_operand=right,
                    #proj_temp=proj_temp,
                    #proj_right=proj_right,
                    temp_reg=temp_reg,
                    inject_result=temp_reg.inject('INT'),
                    #inject_right=right.inject('INT'),
                    )
        else:
            add_func = call_func_asm('add', arguments=[left, right], output=temp_reg)
            proj_left = left.project('BIG', force=True)
            proj_right = right.project('BIG', force=True)
            
            add_code = """
                {proj_left}
                {proj_right}
                {add_func}
                {inject_result}
                {inject_left}
                {inject_right}
            """.format(add_func=add_func,
                    proj_left=proj_left,
                    proj_right=proj_right,
                    inject_result=temp_reg.inject('BIG'),
                    inject_left=left.inject('BIG', force=True),
                    inject_right=right.inject('BIG', force=True))

        assert not self.temp_reg.canSpill()

        return """
            {load_left}
            {add_code}
            {save_result}
        """.format(
            load_left=load_left.write(),
            temp_reg=temp_reg,
            add_code=add_code,
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
        inject = output.inject('INT')

        func = call_func_asm(fname, output=output)

        return """
        {func}
        {inject}
        """.format(
                inject=inject,
                func=func)

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

    def get_memory_operands(self):
        return [
                (self.args[:2], [self.temp_reg]),
                (self.args[:2]+[self.temp_reg], [self.output_key])
                ]


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

    def get_memory_operands(self):
        return [([self.condition], [])]


class OpIfExpr(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        return ""
    def get_memory_operands(self):
        test = self.args[0]
        return [
                ([test], [self.output_key]),
                ]

class OpIs(BasicOperation):
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = True
    def write(self):
        label_eq = LabelManager.newLabel("is_eq")
        label_end = LabelManager.newLabel("is_end")

        left = self.mem.get(self.args[0])
        right = self.mem.get(self.args[1])
        output = self.mem.get(self.output_key)
        temp_reg = self.mem.get(self.temp_reg)

        load_left = self.mem.doLoad(left, temp_reg)

        return """
        {load_left}

        cmpl {right}, {temp}
        je {is_eq}
        movl {false}, {output}
        jmp {end}
        {is_eq}:
        movl {true}, {output}
        {end}:
        """.format(load_left=load_left.write(),
                right=right,
                temp=temp_reg,
                false=CONST(0, tag='BOOL'),
                true=CONST(1, tag='BOOL'),
                output=output,
                is_eq=label_eq,
                end=label_end,
                )

    def get_memory_operands(self):
        return [
                (self.args, [self.temp_reg]),
                (self.args+[self.temp_reg], [self.output_key])
                ]

class OpPrimEquals(AbstractOperation):
    def __init__(self, mem, left, val, invert=False, output_key=None):
        self.mem = mem
        self.left = left
        self.val = val
        if output_key:
            self.output_key = output_key
        else:
            self.output_key = self.mem.allocate(spillable=False)
        self.temp_reg = self.mem.allocate(spillable=False)
        self.invert = invert

    def write(self):
        true_label = LabelManager.newLabel('prim_equals_true')
        end_label = LabelManager.newLabel('prim_equals_end')
        left = self.mem.get(self.left)
        val = self.mem.get(self.val)
        output = self.mem.get(self.output_key)
        temp_reg = self.mem.get(self.temp_reg)

        load_val = self.mem.doLoad(val, temp_reg)

        if self.invert:
            t_val = CONST(False, tag="BOOL")
            f_val = CONST(True, tag="BOOL")
        else:
            t_val = CONST(True, tag="BOOL")
            f_val = CONST(False, tag="BOOL")

        return """
        pushl {left}
        {load_val}
        sarl $2, {left}
        sarl $2, {temp_reg}
        cmpl {left}, {temp_reg}
        je {TRUE}

        movl {f_val}, {output}
        jmp {END}

        {TRUE}:
        movl {t_val}, {output}
        jmp {END}

        {END}:
        popl {left}

        """.format(
                left=left,
                load_val=load_val.write(),
                temp_reg=temp_reg,
                TRUE=true_label,
                END=end_label,
                output=output,
                t_val=t_val, f_val=f_val
                )

    def get_memory_operands(self):
        return [
                ([self.left], [self.temp_reg]),
                ([self.left, self.temp_reg], [self.left, self.temp_reg]),
                ([self.left, self.temp_reg], [self.left, self.temp_reg]),
                ([], [self.output_key]),
                ([], [self.left]),
                ]

class OpBigEquals(AbstractOperation):
    def __init__(self, mem, left, val, invert=False, output_key=None):
        self.mem = mem
        self.left = left
        self.val = val
        if output_key:
            self.output_key = output_key
        else:
            self.output_key = self.mem.allocate(spillable=False)
        self.invert = invert

    def write(self):
        equal_label = LabelManager.newLabel('prim_big_equal')
        end_label = LabelManager.newLabel('prim_big_end')
        left = self.mem.get(self.left)
        val = self.mem.get(self.val)
        output = self.mem.get(self.output_key)
        func = call_func_asm('equal',
                arguments=[left, val],
                output=output)
        if self.invert:
            t_val = CONST(False, tag="BOOL")
            f_val = CONST(True, tag="BOOL")
        else:
            t_val = CONST(True, tag="BOOL")
            f_val = CONST(False, tag="BOOL")

        return """
        {l_proj}
        {v_proj}
        {func}
        cmpl $1, {output}
        je {EQUAL}

        movl {f_val}, {output}
        jmp {END}

        {EQUAL}:
        movl {t_val}, {output}
        jmp {END}

        {END}:
        {l_inj}
        {v_inj}
        """.format(
                l_proj=left.project('BIG', force=True), v_proj=val.project('BIG', force=True),
                l_inj=left.inject('BIG'), v_inj=val.inject('BIG'),
                func=func,
                output=output,
                EQUAL=equal_label,
                f_val=f_val, t_val=t_val,
                END=end_label,
                )

    def get_memory_operands(self):
        return [
                ([self.left, self.val], [self.output_key]),
                ([], [self.output_key]),
                ]
        

class OpJumpOnSame(AbstractOperation):
    HAS_OUTPUT_KEY = False
    def __init__(self, mem, leftCondition, rightCondition, label):
        self.mem = mem
        self.leftCondition = leftCondition 
        self.rightCondition = rightCondition 
        self.label = label
        self.temp = self.mem.allocate(spillable=True)

    def write(self):
        left_cond_alloc = self.mem.get(self.leftCondition)
        right_cond_alloc = self.mem.get(self.rightCondition)

        temp_alloc = self.mem.get(self.temp)

        func_left = call_func_asm('is_big',
                arguments=[left_cond_alloc], output=temp_alloc)
        func_right = call_func_asm('is_big',
                arguments=[right_cond_alloc])
        
        return """
            {func_left}
            {func_right}
            cmpl {temp}, %eax
            je {label}
            """.format(func_left=func_left,
                    func_right=func_right,
                    label=self.label,
                    temp=temp_alloc,
                    )

    def get_memory_operands(self):
        return [
                ([self.leftCondition, self.rightCondition], [self.temp]),
                ([self.temp], [])
                ]

class OpJumpOnTag(AbstractOperation):
    HAS_OUTPUT_KEY = False
    def __init__(self, mem, condition, label, tag, isTag=True):
        self.mem = mem
        self.condition = condition 
        self.label = label
        self.tag = tag
        self.isTag = "$" + str(int(isTag))

    def write(self):
        cond_alloc = self.mem.get(self.condition)

        func = call_func_asm('is_'+self.tag.lower(),
                arguments=[cond_alloc])
        return """
            {func}
            cmpl {value}, %eax 
            je {label}
            """.format(func=func,
                    label=self.label,
                    value=self.isTag)

    def get_memory_operands(self):
        return [([self.condition], [])]


class OpNewConst(AbstractOperation):
    def __init__(self, mem, value, tag='INT'):
        self.mem = mem
        self.value = value
        self.tag = tag
        self.output_key = self.mem.allocate(spillable=True)

    def write(self):
        output_alloc = self.mem.get(self.output_key)
        return """
        movl {value}, {dest} # Allocate new constant
        """.format(
            value=CONST(self.value, tag=self.tag),
            dest=output_alloc,
            )

    def get_memory_operands(self):
        return [ ([], [self.output_key]), ]

class OpDirectAssign(AbstractOperation):
    def __init__(self, mem, left, value, value_is_const=True):
        self.mem = mem
        self.left = left
        self.value = value
        self.value_is_const = value_is_const

    def write(self):
        left = self.mem.get(self.left)
        if not self.value_is_const:
            value = self.mem.get(self.value)
        else:
            value = self.value
        return """
        movl {value}, {left}
        """.format(
                left=left,
                value=value
                )



class OpNot(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        output_alloc = self.mem.get(self.output_key)
        pyobj = self.mem.get(self.args[0])
        func = call_func_asm('is_true',
                arguments=[pyobj],
                output=output_alloc)

        return """
        {func}
        notl {output}
        andl $1, {output}
        {inject}
        """.format(
                func=func,
                output=output_alloc,
                inject=output_alloc.inject('BOOL'),
                )

    def get_memory_operands(self):
        return [ (self.args, [self.output_key]), ]



class OpLabel(AbstractOperation):
    def __init__(self, label_name):
        self.label = label_name
    def write(self):
        return self.label + ":"

class OpJump(AbstractOperation):
    def __init__(self, label_name):
        self.label = label_name
    def write(self):
        return "jmp " + self.label

class OpDict(BasicOperation):
    HAS_OUTPUT_KEY = True
    # TODO: Liveness?
    def add_elem(self, key, elem_ref):
        elem_alloc = self.mem.get(elem_ref)
        out_alloc = self.mem.get(self.output_key)
        key_alloc = self.mem.get(key)

        append = call_func_asm('set_subscript', [out_alloc, key_alloc, elem_alloc])

        return append

    def write(self):
        output = self.mem.get(self.output_key)

        func = call_func_asm("create_dict", arguments=[], output=output)

        code = ""
        for node in self.args[0]:
            code += self.add_elem(node[0], node[1])

        return """
        {func}
        {inject}
        {elem_code}
        """.format(func=func,
                elem_code=code,
                inject=output.inject('BIG', force=True))

    def get_memory_operands(self):
        all_vals = [val[0] for val in self.args[0]] + [val[1] for val in self.args[0]]
        return [
                (all_vals, [self.output_key]),
                (all_vals+[self.output_key], [self.output_key])
                ]

class OpSubscript(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        pyobj = self.mem.get(self.args[0])
        key = self.mem.get(self.args[1])
        output = self.mem.get(self.output_key)

        return call_func_asm('get_subscript',
                arguments=[pyobj, key],
                output=output)

    def get_memory_operands(self):
        return [(self.args, [self.output_key])]


class OpSetSubscript(BasicOperation):
    HAS_OUTPUT_KEY = False

    def write(self):
        pyobj = self.mem.get(self.args[0])
        key = self.mem.get(self.args[1])
        value = self.mem.get(self.args[2])

        append = call_func_asm('set_subscript', [pyobj, key, value])

        return """
        {append}
        """.format( append=append)

    def get_memory_operands(self):
        return [ (self.args, [self.args[0]])]


class OpList(AbstractOperation):
    def __init__(self, mem, nodes):
        self.mem = mem
        self.output_key = self.mem.allocate(spillable=True)
        self.nodes = nodes
        #self.temp_var = self.mem.allocate(spillable=True)

    # TODO: Liveness?
    def add_elem(self, idx, elem_ref):
        elem_alloc = self.mem.get(elem_ref)
        out_alloc = self.mem.get(self.output_key)

        append = call_func_asm('set_subscript', [out_alloc, CONST(idx, tag="INT"), elem_alloc])

        return append

    def write(self):
        output_alloc = self.mem.get(self.output_key)
        elems = self.nodes

        mk_list = call_func_asm('create_list', [CONST(len(elems), tag="INT")], output_alloc)
        inject_big = output_alloc.inject('BIG')
        elem_code = ""
        for idx, ref in enumerate(elems):
            elem_code += self.add_elem(idx, ref)

        return """
        {mk_list}
        {inject_big}
        {elem_code}
        """.format(
                mk_list=mk_list,
                elem_code=elem_code,
                inject_big=inject_big)

    def get_memory_operands(self):
        return [
                (self.nodes, [self.output_key]),
                (self.nodes+[self.output_key], [self.output_key])
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
