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
from ..util.cache import LeastRecentlyUsedCache
from ..operations.memory import OpMovl, OpStackAllocate, OpStackDeallocate, OpNoop
from ..memory.anonymous_identifier import AnonymousIdentifier, NamedIdentifier
import itertools

class MemoryManager:
    def __init__(self, instrWriter):
        self.registers = ['ebx', 'ecx', 'edx', 'edi']
        self.register_alloc = LeastRecentlyUsedCache()
        self.memory_alloc = {}
        self.named_vars = {}
        self.instrWriter = instrWriter
        self.stack_alloc = OpStackAllocate(0)
        self.memoryAccesses = []

    def getStackAllocation(self):
        return self.stack_alloc
       
    def get(self, key, address_only=False):
        #dbg.log.printstack()
        dbg.log("Retrieving:", key)
        if not address_only and self.register_alloc.contains(key):
            # Put key at the top of LRU
            ret = "%" + self.register_alloc.getRegisterByKey(key)
            dbg.log("Retrieved Register:", ret)
            return ret
        else:
            # self.memory_alloc[key] == "-16(%ebp)" ,    ".data_label_thing
            ret = self.memory_alloc[key]
            dbg.log("Retrieved Address:", ret)
            return ret

    def allocate(self, name=None, size=4):
        if name == None:
            name = AnonymousIdentifier()
        dbg.log("Allocating stack space for '", name, "'")
        self.stack_alloc.size += size
        self.memory_alloc[name] = "-" + str(self.stack_alloc.size) + "(%ebp)"
        return name

    def ensureRegister(self, name):
        if not self.register_alloc.contains(name):
            addr = self.memory_alloc[name]
            register = "%" + self.register_alloc.set(name)

            movl = OpMovl(addr, register)
            return movl
        else:
            self.register_alloc.prioritize(name)
            return OpNoop()

    def doLoad(self, left, right):
        load = OpMovl(left, right)

        return load

    def saveRegister(self, register, key):
        addr = self.memory_alloc[key]

        movl = OpMovl(register, addr)

        register = register.replace("%", "")
        dbg.log("CLEARING REGISTER: ", register)
        self.register_alloc.clearRegister(register)
        return movl

    def finalize(self):
        op = OpStackDeallocate(self.stack_alloc.size)
        self.instrWriter.write(op)

    def clearRegisters(self):
        self.register_alloc.clearAll()

    def memoryOperation(self, readsFrom, writeTo):
        self.memoryAccesses.append((list(readsFrom), list(writeTo)))

    def getReference(self, name):
        if name not in self.named_vars:
            self.named_vars[name] = NamedIdentifier(name)

        return self.named_vars[name]
        

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
        for idx, (_, writes) in enumerate(self.memoryAccesses):
            candidates = writes + currentVars
            currentVars = []
            for term in candidates:
                if is_alive(term, self.memoryAccesses[idx+1:]):
                    currentVars.append(term)

            liveness.append(currentVars)
        edges = {}
        print liveness
        for iteration in liveness:
            perms = itertools.permutations(iteration, 2)
            for (l, r) in perms:
                if l not in edges:
                    edges[l] = []
                if r not in edges[l]:
                    edges[l].append(r)
        for edge in edges:
            print edge, ":", edges[edge]

