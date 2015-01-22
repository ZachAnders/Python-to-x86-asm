from compiler.ast import Module, Stmt, Printnl, Assign
from compiler.ast import Discard, Const, Name, Add, UnarySub

from handlers import Handler


class Dispatcher():
    def __init__(self, mem, instrWriter):
        self.instrWriter = instrWriter
        self.handler = Handler(self, mem, instrWriter)

    def dispatch(self, ast):
        operations = {
            Module : self.handler.doModule,
            Stmt : self.handler.doStmt,
            Printnl : self.handler.doPrintnl,
            Assign : self.handler.doAssign,
            Discard : self.handler.doDiscard,
            Const : self.handler.doConst,
            Name : self.handler.doName,
            Add : self.handler.doAdd,
            UnarySub : self.handler.doUnarySub,
        }
        return operations[ast.__class__](ast)

    def dispatch_many(self, ast):
        return [self.dispatch(child) for child in ast.nodes]
