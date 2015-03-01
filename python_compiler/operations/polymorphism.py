#from ..debug import dbg
from .base import BasicOperation, BasicOperation
from .helpers import call_func_asm

class OpIsBig(BasicOperation):
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = False

    def write(self):
        ptr = self.args[0]
        myObj = self.mem.get(ptr)
        output = self.mem.get(self.output_key)

        is_big = call_func_asm('is_big', arguments=[myObj], output=output)
        inject_code = myObj.inject('BOOL', output)

        return """
            {is_big}
            {inject}
        """.format(
                is_big=is_big,
                inject=inject_code,
                )
        
    def get_memory_operands(self):
        return [([self.args], [self.output_key])]

class OpIsInt(BasicOperation):
    pass

class OpIsBool(BasicOperation):
    pass

#class OpConvertToInt(BasicOperation):
#    pass
#
#class OpConvertToList(BasicOperation):
#    pass
#d
class OpConvertToDict(BasicOperation):
    pass
#    pass
