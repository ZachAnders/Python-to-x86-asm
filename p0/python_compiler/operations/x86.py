
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
            {load} # Load left Add operand
            addl {right_operand}, {accumulator} # Add right operand to left
            movl {accumulator}, {output_addr} # Save Add result
        """.format(
            load=load_op.write().strip(),
            accumulator=left,
            right_operand=right,
            output_addr=out_addr)

class OpUnarySub(Operation):
    def write(self):
        load_op = self.mem.ensureRegister(self.args[0])
        node = self.mem.get(self.args[0])

        out_addr = self.mem.get(self.output_key, address_only=True)
        save_op = self.mem.saveRegister(node, self.output_key)

        return """
            {load} # Load Unary Sub operand
            negl {register} # Neg operand
            {save} # Save operand
        """.format(
            load=load_op.write().strip(),
            register=node,
            output_addr=out_addr,
            save=save_op.write().strip())
# movl {register}, {output_addr} # Save Unary Sub output

class OpPrintnl(ReadonlyOperation):
    def write(self):
        load_op = self.mem.ensureRegister(self.args[0])
        left = self.mem.get(self.args[0])
        return """
        {load} # Load print operand
        pushl {value_reg} # Put operand on stack
        call print_int_nl # Call print
        """.format(
            load=load_op.write().strip(),
            value_reg=left)
        #popl {value_reg}

class OpCallFunc(Operation):
    def write(self):
        #load_op = self.mem.ensureRegister(self.args[0])
        save_op = self.mem.saveRegister("%eax", self.output_key).write().strip()
        #left = self.mem.get(self.args[0])
        # {load}
        return """
        call {name} # Call func
        {save_op} # Save func results
        """.format(
            name=self.args[0],
            save_op=save_op)
            #load=load_op.write(),

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
        return """
            {load_op} # Load Assign right param
            {save_op} # Store into Assign left param
        """ .format(
            load_op=load_op.write().strip(),
            save_op=save_op.write().strip())

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
