from ..operations.x86 import OpAdd, OpModule, OpStmt, OpPrintnl, OpAssign, OpUnarySub, OpNewConst, OpReturn

class Handler():
    def __init__(self, dispatcher, mem, instrWriter):
        self.mem = mem
        self.instrWriter = instrWriter
        self.dispatcher = dispatcher

    def doAdd(self, ast):
        left = self.dispatcher.dispatch(ast.left)
        right = self.dispatcher.dispatch(ast.right)
        op = OpAdd(self.mem, left, right)
        self.instrWriter.write(op)
        return op.output_key
        
    def doModule(self, ast):
        op = OpModule(self.mem)
        self.instrWriter.write(op)
        _ = self.dispatcher.dispatch(ast.node)
        return None

    def doStmt(self, ast):
        op = OpStmt(self.mem)
        self.instrWriter.write(op)
        _ = self.dispatcher.dispatch_many(ast)
        ret = OpReturn(self.mem)
        self.mem.finalize()
        self.instrWriter.write(ret)
        return None

    def doPrintnl(self, ast):
        items = self.dispatcher.dispatch_many(ast)
        # l: value to print, r: destination to print to
        for node in items:
            op = OpPrintnl(self.mem, node)
            self.instrWriter.write(op)
        return None
            
    def doAssign(self, ast):
        names, value_ref = ast.nodes, self.dispatcher.dispatch(ast.expr)
        for name in names:
            op = OpAssign(self.mem, name.name, value_ref)
            self.instrWriter.write(op)
        return None

    def doDiscard(self, ast):
        _ = self.dispatcher.dispatch(ast.expr)
        return None

    def doConst(self, ast):
        # No dispatch on const decls
        op = OpNewConst(self.mem, ast.value)
        self.instrWriter.write(op)
        return op.output_key

    def doName(self, ast):
        #left, right = self.dispatcher.dispatch_many(self, ast)
        #op = OpAdd(self.mem, left, right)
        #self.instrWriter.write(op)
        return ast.name

    def doUnarySub(self, ast):
        node = self.dispatcher.dispatch(self, ast)
        op = OpUnarySub(self.mem, node)
        self.instrWriter.write(op)
        return op.output_key
