from ..debug import dbg
from .base import AbstractOperation

class BasicOperation(AbstractOperation):
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = args


        if self.HAS_OUTPUT_KEY:
            self.output_key = self.mem.allocate(spillable=True)
            self.outputs = [self.output_key]
            self.accesses = [(self.args, self.outputs)]
        else:
            self.outputs = []
            self.accesses = [(self.args, [])]

        if self.HAS_TEMP_REG:
            self.temp_reg = self.mem.allocate(spillable=False)
            #self.accesses = [(self.args, [self.temp_reg])] + self.accesses
            self.accesses = [
                    (self.args, [self.temp_reg]),
                    (self.args, [self.temp_reg]),
                    ([self.temp_reg], [self.outputs])]


    def get_memory_operands(self):
        return self.accesses

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

        # TODO: Callee, Caller save registers
        return """
        pushl %ebx
        pushl %ecx
        pushl %edx
        pushl {value_reg} # Put operand on stack
        call print_int_nl # Call print
        popl {value_reg}
        popl %edx
        popl %ecx
        popl %ebx
        """.format(
            value_reg=left)

class OpCallFunc(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        fname = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)
        # TODO: Callee, Caller save registers
        return """
        pushl %ebx
        pushl %ecx
        pushl %edx
        call {name} # Call func
        popl %edx
        popl %ecx
        popl %ebx
        movl %eax, {output} # Save func results
        """.format(
            name=fname,
            output=output)

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

class OpNewConst(BasicOperation):
    HAS_OUTPUT_KEY = True
    def write(self):
        return """
        movl ${value}, {dest} # Allocate new constant
        """.format(
            value=self.args[0],
            dest=self.mem.get(self.output_key))

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
        #self.mem.ensureRegister(self.args[0])
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
