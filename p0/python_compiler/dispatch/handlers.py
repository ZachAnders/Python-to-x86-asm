from ..operations.x86 import OpAdd, OpModule, OpStmt, OpPrintnl, OpAssign, OpUnarySub

class Handler():
    def __init__(self, dispatcher, mem, instrWriter):
        self.mem = mem
        self.instrWriter = instrWriter
        self.dispatcher = dispatcher

    def doAdd(self, ast):
        left, right = self.dispatcher.dispatch_many(ast)
        op = OpAdd(self.mem, left, right)
        self.instrWriter.write(op)
        return op.key
        
    def doModule(self, ast):
        _ = self.dispatcher.dispatch_many(ast)
        op = OpModule(self.mem)
        self.instrWriter.write(op)
        return None

    def doStmt(self, ast):
        _ = self.dispatcher.dispatch_many(ast)
        op = OpStmt(self.mem)
        self.instrWriter.write(op)
        return None

    def doPrintnl(self, ast):
        left, right = self.dispatcher.dispatch_many(ast)
        # l: value to print, r: destination to print to
        for node in left:
            op = OpPrintnl(self.mem, node, right)
            self.instrWriter.write(op)
        return None
            
    def doAssign(self, ast):
        left, right = self.dispatcher.dispatch_many(ast)
        op = OpAssign(self.mem, left, right)
        self.instrWriter.write(op)
        return op.key

    def doAssName(self, ast):
        _ = self.dispatcher.dispatch_many(ast)
        return None

    def doDiscard(self, ast):
        left, right = self.dispatcher.dispatch_many(self, ast)
        op = OpDiscard(mem, left, right)
        self.instrWriter.write(op)
        return op.key

    def doConst(self, ast):
        node = self.dispatcher.dispatch(self, ast)
#        op = OpUnarySub(mem, node)
        self.instrWriter.write(op)
        return None # TODO: GET REF

    def doName(self, ast):
        left, right = self.dispatcher.dispatch_many(self, ast)
        op = OpAdd(self.mem, left, right)
        self.instrWriter.write(op)
        return op.key

    def doUnarySub(self, ast):
        node = self.dispatcher.dispatch(self, ast)
        op = OpUnarySub(self.mem, node)
        self.instrWriter.write(op)
        return op.key
