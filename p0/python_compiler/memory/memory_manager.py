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

class MemoryManager:
    CHAR = 1
    INT = 4
    SHORT = 2
    LONG = 4
    STR = 1
    def __init__(self, instrWriter):
        self.registers = ['ebx', 'ecx', 'edx', 'esi', 'edi']
        self.register_alloc = {}
        self.memory_alloc = {}
        self.size = 0
        self.instrWriter = instrWriter
    def get(self, arg):
        dbg.log("Retrieving:", arg)
        if arg in self.register_alloc:
            # Put arg at the top of LRU
            return "%" + self.register_alloc[arg]
        else:
            # self.memory_alloc[arg] == "-16(%ebp)" ,    ".data_label_thing
            return self.memory_alloc[arg]

    def allocateStack(self, name, size=4):
        dbg.log("Allocating stack space for '", name, "'")
        self.size += size
        self.memory_alloc[name] = "-" + str(self.size) + "(%ebp)"

    def ensureRegister(self, name):
        #TODO: This
        pass
        
        # Make sure not already in register

        #reg = # Find least recently used register 
        #self.instrWriter.write(OpMovl(self.get(name), reg))
