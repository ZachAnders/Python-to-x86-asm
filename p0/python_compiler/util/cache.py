class LeastRecentlyUsedCache:
    def __init__(self):
        self.registers = ['ebx', 'ecx', 'edx', 'esi', 'edi']
        self.registers_alloc = {}
        for r in self.registers:
            self.registers_alloc[r] = None

    def set(self, value):
        if not self.contains(value):
            register = self.registers[0]
            self.registers_alloc[register] = value
            self.__used__(register)
            return register
        else:
            return self.getRegisterByKey(value)

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

    def contains(self, key):
        for r in self.registers_alloc:
            if self.registers_alloc[r] == key:
                return True
        return False

    def prioritize(self, key):
        self.__used__(self.getRegisterByKey(key))

    def clear(self, key):
        if self.contains(key):
            reg = self.getRegisterByKey(key)
            del self.registers_alloc[reg]
