
from .debug import dbg

class Operation():
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = args

class OpAdd(Operation):
    def write(self, instWriter):
        self.mem.ensureRegister(self.args[0])
        left = self.mem.get(self.args[0])
        right = self.mem.get(self.args[1])
        return "addl %s, %s" % (left, right)

class OpUnarySub(Operation):
    def write(self, instWriter):
        self.mem.ensureRegister(self.args[0])
        node = self.mem.get(self.args[0])
        return "negl %s" % (node)

class OpPrintnl(Operation):
    def write(self, instWriter):
        #pushl -x(%ebp)
        #call print_int_nl
        #addl 4, %ebp

