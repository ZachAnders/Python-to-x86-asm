class OpMovl():
    def __init__(self, source, dest):
        self.src = source
        self.dst = dest

    def write(self):
        return """
        movl %s, %s
        """ % (self.src, self.dst)

class OpNoop():
    def write(self):
        return ""

class OpStackAllocate():
    def __init__(self, size):
        self.size = size

    def write(self):
        return """
        subl ${size}, %esp
        """.format(
            size=self.size)

class OpStackDeallocate():
    def __init__(self, size):
        self.size = size

    def write(self):
        return """
        addl ${size}, %esp
        """.format(
            size=self.size)
