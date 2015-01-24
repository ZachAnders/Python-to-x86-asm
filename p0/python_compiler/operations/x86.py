
from ..debug import dbg

class Operation():
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = args
        self.output_key = self.mem.allocateStack()

class ReadonlyOperation():
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = args
        self.output_key = None

class OpAdd(Operation):
    def write(self):
        dbg.log(self.args[0])
        load_op = self.mem.ensureRegister(self.args[0])
        left = self.mem.get(self.args[0])
        right = self.mem.get(self.args[1])

        out_addr = self.mem.get(self.output_key, address_only=True)

        return """
            {load}
            addl {accumulator}, {right_operand}
            movl {accumulator}, {output_addr}
        """.format(
            load=load_op.write(),
            accumulator=left,
            right_operand=right,
            output_addr=out_addr)

class OpUnarySub(Operation):
    def write(self):
        load_op = self.mem.ensureRegister(self.args[0])
        node = self.mem.get(self.args[0])

        out_addr = self.mem.get(self.output_key, address_only=True)

        return """
            {load}
            negl {register}
            movl {register}, {output_addr}
        """.format(
            load=load_op.write(),
            register=node,
            output_addr=out_addr)

class OpPrintnl(ReadonlyOperation):
    def write(self):
        load_op = self.mem.ensureRegister(self.args[0])
        left = self.mem.get(self.args[0])
        return """
        {load}
        pushl {value_reg} 
        call print_int_nl
        """.format(
            load=load_op.write(),
            value_reg=left)
        #popl {value_reg}

class OpCallFunc(Operation):
    def write(self):
        load_op = self.mem.ensureRegister(self.args[0])
        left = self.mem.get(self.args[0])
        return """
        {load}
        call {name} 
        """.format(
            load=load_op.write(),
            name=left)

class OpAssign():
    def __init__(self, mem, name, value_ref):
        self.mem = mem
        self.name = name
        self.value_ref = value_ref

        # Make stack space for this variable
        self.mem.allocateStack(self.name)

    def write(self):
        # Load the result into a register
        load_op = self.mem.ensureRegister(self.value_ref)
        # Get the register with the result in it
        register = self.mem.get(self.value_ref)
        # Save the register's result into this variable's new stack space
        save_op = self.mem.saveRegister(register, self.name)
        return "\n".join([load_op.write(), save_op.write()])

class OpNewConst(Operation):
    def write(self):
        return """
        movl ${value}, {dest}
        """.format(
            value=self.args[0],
            dest=self.mem.get(self.output_key, address_only=True))

class OpStmt(ReadonlyOperation):
    def write(self):
        return """
        pushl %ebp
        movl %esp, %ebp
        {allocate_stack}
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
        movl $0, %eax
        leave
        ret
        """
