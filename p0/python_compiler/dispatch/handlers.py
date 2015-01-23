from .operations.x86 import OpAdd

class Handler():
    def __init__(self, dispatcher, mem, instrWriter):
        self.mem = mem
        self.instrWriter = instrWriter
        self.dispatcher = dispatcher

    def doAdd(self, ast):
        left, right = self.dispatcher.dispatch_many(self, ast)
        op = OpAdd(self.mem, left, right)
        self.instrWriter.write(op)
        return op.key
        
    def doModule(self, ast):
        _ = self.dispatcher.dispatch_many(self, ast)
        #self.instrWriter.write(op)
        return None

    def doStmt(self, ast):
        _ = self.dispatcher.dispatch_many(self, ast)
        #self.instrWriter.write(op)
        return None

    def doPrintnl(self, ast):
            left, right = self.dispatcher.dispatch_many(self, ast)
            # l: value to print, r: destination to print to
            op = OpPrintnl(mem,left,right);
            self.instrWriter.write(op)
            return None
            
    def doAssign(self, ast):
        left, right = self.dispatcher.dispatch_many(self, ast)
        op = OpAssign(mem, left, right)
        self.instrWriter.write(op)
        return op.key

    def doDiscard(self, ast):
        left, right = self.dispatcher.dispatch_many(self, ast)
        op = OpDiscard(mem, left, right)
        self.instrWriter.write(op)
        return op.key

    def doConst(self, ast):
        node = self.dispatcher.dispatch(self, ast)
        op = OpUnarySub(mem, node)
        self.instrWriter.write(op)
        return op.key

    def doName(self, ast):
        left, right = self.dispatcher.dispatch_many(self, ast)
        op = OpAdd(mem, left, right)
        self.instrWriter.write(op)
        return op.key

    def doUnarySub(self, ast):
        node = self.dispatcher.dispatch(self, ast)
        op = OpUnarySub(mem, node)
        self.instrWriter.write(op)
        return op.key
