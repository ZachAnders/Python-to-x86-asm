""" 
dispatcher.py:
    Dispatcher() : class
        The Dispatcher is what is responsible for 'flattening' the AST.

    Date: 01/22/15
    Authors:
       Brian Bauer 
       Zach Anders
"""

from compiler.ast import Module, Stmt, Printnl, Assign, CallFunc
from compiler.ast import Discard, Const, Name, Add, UnarySub
from compiler.ast import List, Or, And, Compare, Not, Dict, Subscript, IfExp    

from ..debug import dbg
from ..memory.memory_manager import MemoryManager
from ..writer.instruction_pipeline import InstructionPipeline

from handlers import Handler


class Dispatcher():
    """
        The Dispatcher recursively walks down the AST, dispatching the appropriate handler
        for each node it encounters. These handlers may make further calls
        back into the Dispatcher, in the event that child dependencies need to be resolved.
    """
    def __init__(self):
        """
            Construct a new AST instruction Dispatcher
        """
        self.instrWriter = InstructionPipeline()
        self.mem = MemoryManager(self.instrWriter)

        self.handler = Handler(self, self.mem, self.instrWriter)

    def dispatch(self, ast):
        """ 
            Find the
        """
        dbg.log("Dispatching :", ast)
        operations = {
            Module      : self.handler.doModule,
            Stmt        : self.handler.doStmt,
            Printnl     : self.handler.doPrintnl,
            CallFunc    : self.handler.doCallFunc,
            Assign      : self.handler.doAssign,
            Discard     : self.handler.doDiscard,
            Const       : self.handler.doConst,
            Name        : self.handler.doName,
            Add         : self.handler.doAdd,
            UnarySub    : self.handler.doUnarySub,
            List        : self.handler.doList,
            Or          : self.handler.doOr,
            And         : self.handler.doAnd,
            Compare     : self.handler.doCompare,
            Not         : self.handler.doNot,
            Dict        : self.handler.doDict,
            Subscript   : self.handler.doSubscript,
            IfExp       : self.handler.doIfExp,
        }

        # The keys are Python classes, so we can dispatch directly with the class of 'ast'
        return operations[ast.__class__](ast)

    def dispatch_many(self, ast):
        return [self.dispatch(child) for child in ast.nodes]

    def write_out(self, filename=None):
        self.mem.liveness()
        return self.instrWriter.export(fname=filename)
