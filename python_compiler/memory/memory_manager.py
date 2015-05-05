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
from ..operations.helpers import LabelManager
from ..memory.variable_identifier import AnonymousIdentifier, NamedIdentifier, PassThroughIdentifier
import itertools
from .allocation_identifier import RegisterAllocation, StackAllocation

class MemoryManager:
    def __init__(self, instrWriter):
        self.allocations = {}
        self.key_counter = 0
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
            if key in self.allocations:
                return self.allocations[key]
            else:
                self.allocations[key] = str(self.key_counter)
        except KeyError, e:
            print self.allocations
            print "Failed get key: %s" % str(key)
            print key.printAllocation()
            raise e

    def allocate(self, name=None):
        if name == None:
            newVar = AnonymousIdentifier()
            self.anon_vars.append(newVar)
            self.allocations[newVar] = "%" + LabelManager.newLabel("anon_var")
        else:
            if name in self.named_vars:
                return self.named_vars[name]
            newVar = NamedIdentifier(name)
            self.named_vars[name] = newVar

            self.allocations[newVar] = "%" + LabelManager.newLabel(name)
        return newVar

    def doLoad(self, left, right):
        if left != right:
            load = OpMovl(left, right)
        else:
            load = OpNoop()

        return load

    def finalize(self):
        pass
        #op = OpStackDeallocate(self.stack_alloc.size)
        #self.instrWriter.write(op)

    def getReference(self, name):
        return self.named_vars[name]
