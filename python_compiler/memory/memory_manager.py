"""

memory_manager.py:
    MemoryManager() : class
        Manages the mappings between names and addresses/registers

    Date: 01/22/15
    Authors:
       Brian Bauer 
       Zach Anders
"""

from ..debug import dbg
from ..operations.memory import OpMovl, OpStackAllocate, OpStackDeallocate, OpNoop
from ..memory.variable_identifier import AnonymousIdentifier, NamedIdentifier, PassThroughIdentifier
from ..util.colorize import DSATUR
import itertools
from .allocation_identifier import RegisterAllocation, StackAllocation

class MemoryManager:
    def __init__(self, instrWriter):
        self.registers = ['ebx', 'ecx', 'edx']
        self.allocations = {}
        self.named_vars = {}
        self.anon_vars = []
        self.instrWriter = instrWriter
        self.stack_alloc = OpStackAllocate(0)
        self.builtins = ['input']

        for builtin in self.builtins:
            bvar = PassThroughIdentifier(builtin)
            self.named_vars[builtin] = bvar
            self.allocations[bvar] = 'input'
        #print self.allocations


    def getStackAllocation(self):
        return self.stack_alloc
       
    def get(self, key):
        dbg.log("Retrieving:", key)
        try:
            return self.allocations[key]
        except KeyError, e:
            print self.allocations
            print "Failed get key: %s" % str(key)
            print key.printAllocation()
            raise e

    def allocate(self, name=None):
        if name == None:
            newVar = AnonymousIdentifier()
            self.anon_vars.append(newVar)
        else:
            if name in self.named_vars:
                return self.named_vars[name]
            newVar = NamedIdentifier(name)
            self.named_vars[name] = newVar

        return newVar

    def doLoad(self, left, right):
        if left != right:
            load = OpMovl(left, right)
        else:
            load = OpNoop()

        return load

    def finalize(self):
        op = OpStackDeallocate(self.stack_alloc.size)
        self.instrWriter.write(op)

    def getReference(self, name):
        return self.named_vars[name]
