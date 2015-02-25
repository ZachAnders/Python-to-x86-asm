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

class MemoryManager:
    def __init__(self, instrWriter):
        self.registers = ['ebx', 'ecx', 'edx']
        self.allocations = {}
        self.named_vars = {}
        self.anon_vars = []
        self.instrWriter = instrWriter
        self.stack_alloc = OpStackAllocate(0)
        #self.memoryAccesses = []
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

    def allocate(self, name=None, spillable=True):
        if name == None:
            newVar = AnonymousIdentifier(spillable=spillable)
            self.anon_vars.append(newVar)
        else:
            if name in self.named_vars:
                return self.named_vars[name]
            newVar = NamedIdentifier(name, spillable=spillable)
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

#    def memoryOperation(self, readsFrom, writeTo):
#        self.memoryAccesses.append((list(readsFrom), list(writeTo)))

    def getReference(self, name):
#        if name in self.builtins:
#            return PassThroughIdentifier(name)
#        if name not in self.named_vars:
#            self.named_vars[name] = NamedIdentifier(name)
        return self.named_vars[name]

    def getAccesses(self):
        memoryAccesses = []
        for instr in self.instrWriter.instructions:
            memoryAccesses += instr.get_memory_operands()
        return memoryAccesses

    def liveness(self):
        def is_alive(tmp, rest_of_accesses):
            for reads, writes in rest_of_accesses:
                if tmp in reads:
                    return True
                elif tmp in writes:
                    return False
            return False
        
        liveness = []
        currentVars = []
        memoryAccesses = self.getAccesses()
        for idx, (_, writes) in enumerate(memoryAccesses):
            candidates = writes + currentVars
            currentVars = []
            for term in candidates:
                if is_alive(term, memoryAccesses[idx+1:]):
                    currentVars.append(term)

            liveness.append(currentVars)
        edges = {alloc:[] for alloc in self.named_vars.values() + self.anon_vars if alloc.shouldAllocate()}
#        print liveness
        for iteration in liveness:
            perms = itertools.permutations(iteration, 2)
            for (l, r) in perms:
                if l not in edges:
                    edges[l] = []
                if r not in edges[l]:
                    edges[l].append(r)

        c = DSATUR(edges, len(self.registers))
        c.run()
        allocs = c.getColor()
        for alloc_var in allocs:
            color_id = allocs[alloc_var]
            if color_id < len(self.registers):
                # Goes in register
                self.allocations[alloc_var] = "%" + self.registers[color_id]
            else:
                # Goes in memory
                self.stack_alloc.size += 4
                self.allocations[alloc_var] = "-" + str(self.stack_alloc.size) + "(%ebp)"
#        print self.allocations
