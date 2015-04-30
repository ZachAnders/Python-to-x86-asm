class AbstractOperation(object):
    HAS_OUTPUT_KEY = False # Defaults to False

    def has_output_key(self):
        return self.HAS_OUTPUT_KEY

class BasicOperation(AbstractOperation):
    def __init__(self, mem, *args):
        self.mem = mem
        self.args = list(args)


        if self.HAS_OUTPUT_KEY:
            self.output_key = self.mem.allocate(spillable=True)
        else:
            pass

    def get_output_key(self):
        if self.HAS_OUTPUT_KEY:
            return self.output_key
        else:
            raise RuntimeError("Operation does not have output key: " + str(self))
