from .base import AbstratOperation, BasicOperation

class OpAdd(BasicOperation):
    HAS_OUTPUT_KEY = True
    def __init__(self, mem, left, right, is_int=True, output_key=None):
        self.mem = mem
        self.left = left
        self.right  = right
        self.is_int = is_int
        if output_key is None:
            self.output_key = self.mem.allocate()
        else:
            self.output_key = output_key
    
    def write(self):
        dbg.log(self.left)
        left = self.mem.get(self.left)
        right = self.mem.get(self.right)

        # Get temp variable to store value (SSA)
        output = self.mem.get(self.output_key)
        temp_var = self.mem.get(self.temp_var)
        if self.is_int:
            add_code = """
               {temp_var} = add i32 {left_operand}, {right_operand}
               {output}
               """.format(left_operand=left_operand,
                       right_operand=right_operand,
                       temp_var=temp_var,
                       output=output)
        return """
            {add_code}
        """.format(add_code=add_code)


class OpUnarySub(BasicOperation):
    HAS_OUTPUT_KEY = True
    HAS_TEMP_REG = True
    def write(self):
        node = self.mem.get(self.args[0])
        output = self.mem.get(self.output_key)

        temp_var = self.mem.get(self.temp_var)

        load_op = self.mem.doLoad(node, temp_var)
        save_op = self.mem.doLoad(temp_var, output)

        return """
            {temp_var} = sub i32 0, {node}
        """.format(
                temp_var=temp_var,
                node=node)

class OpPrintnl(BasicOperation):
    HAS_OUTPUT_KEY = False
    def write(self):
        left = self.mem.get(self.args[0])
        return call_func_asm('print_any', arguments=[left])
