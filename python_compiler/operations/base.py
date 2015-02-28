class AbstractOperation():
    HAS_OUTPUT_KEY = False # Defaults to False
    HAS_TEMP_REG = False # Default to no temp reg

    def get_memory_operands(self):
        return []

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

