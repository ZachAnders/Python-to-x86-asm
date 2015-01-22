class LeastRecentlyUsedCache:
    def __init__(self):
        self.registers = ['ebx', 'ecx', 'edx', 'esi', 'edi']
        self.registers_alloc = {}
        for r in self.registers:
            self.registers_alloc[r] = None

    def set(self, value):
        register = self.registers[0]
        self.registers_alloc[register] = value
        self.__used__(register)

    def getKeyByRegister(self, register):
        self.__used__(register)
        return self.registers_alloc[register] 

    def getRegisterByKey(self, key):
        rev = {v:k for (k, v) in self.registers_alloc.items()}
        self.__used__(rev[key])
        return rev[key]

    def __used__(self, register):
        self.registers.remove(register)
        self.registers.append(register)
