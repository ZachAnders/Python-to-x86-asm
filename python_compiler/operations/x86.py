
from ..debug import dbg

class Operation():
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = args
        # TODO: Tell the memory manager what variables we have
        self.output_key = self.mem.allocate()

        self.mem.memoryOperation(args, [self.output_key])

class ReadonlyOperation():
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = args
        self.output_key = None
        self.mem.memoryOperation(args, [])

class OpAdd(Operation):
    def __init__(self, mem, left, right):
        self.mem = mem
        self.left = left
        self.right = right

        # TODO: Ensure in register
        self.output_key = self.mem.allocate()

        # Output:
        """
        movl (left), (temp)
        addl (right), (temp)
        """
        self.mem.memoryOperation([left], [self.output_key])
        self.mem.memoryOperation([right, self.output_key], [self.output_key])

    def write(self):
        dbg.log(self.left)
        left = self.mem.get(self.left)
        right = self.mem.get(self.right) # Needs to be a register!

        output = self.mem.get(self.output_key)
        load = self.mem.doLoad(left, output)

        return """
            {load}
            addl {right_operand}, {accumulator} # Add right operand to left
        """.format(
            load=load.write(),
            accumulator=output,
            right_operand=right,
            left_operand=left)


class OpUnarySub(Operation):
    def write(self):
        node = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)

        load_op = self.mem.doLoad(node, output)

        return """
            {load} # Load Unary Sub operand
            negl {output} # Neg operand
        """.format(
            load=load_op.write().strip(),
            register=node,
            output_addr=output)

class OpPrintnl(Operation):
    def write(self):
        left = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)

        load_op = self.mem.doLoad(left, output)
        # TODO: Callee, Caller save registers
        return """
        {load} # Load print operand
        pushl {value_reg} # Put operand on stack
        call print_int_nl # Call print
        """.format(
            load=load_op,
            value_reg=left)

class OpCallFunc(Operation):
    def write(self):
        # TODO: Callee, Caller save registers
        
        return """
        call {name} # Call func
        movl %eax, {output} # Save func results
        """.format(
            name=self.args[0])

class OpAssign():
    def __init__(self, mem, name, value_ref):
        self.mem = mem
        self.name = name
        self.value_ref = value_ref

        self.mem.memoryOperation([value_ref], [self.name])

        self.temp_register = self.mem.allocate() #TODO Make register

        # Make stack space for this variable
        self.mem.allocate(self.name)

        self.mem.memoryOperation([value_ref], [self.temp_register])
        self.mem.memoryOperation([self.temp_register], [self.name])

    def write(self):
        # Get the register with the result in it
        register = self.mem.get(self.value_ref)
        output = self.mem.get(self.name)
        load_op_tmp = self.mem.doLoad(self.value_ref, self.temp_register)
        load_op_dest = self.mem.doLoad(self.temp_register, self.name)

        return """
            {load_tmp}
            {tmp_to_dest}
        """ .format(
            load_tmp=load_op_tmp.write(),
            load_op_dest=load_op_dest.write())

class OpNewConst(Operation):
    def write(self):
        return """
        movl ${value}, {dest} # Allocate new constant
        """.format(
            value=self.args[0],
            dest=self.mem.get(self.output_key, address_only=True))

class OpStmt(ReadonlyOperation):
    def write(self):
        return """
        pushl %ebp
        movl %esp, %ebp
        {allocate_stack} # Allocate stack
        """.format(
            allocate_stack=self.mem.getStackAllocation().write())

class OpModule(ReadonlyOperation):
    def write(self):
        #self.mem.ensureRegister(self.args[0])
        return """
        .global main
        main:
        """

class OpReturn(ReadonlyOperation):
    def write(self):
        return """
        movl $0, %eax # Zero eax return code
        leave
        ret
        """
