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
