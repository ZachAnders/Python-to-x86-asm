from ..debug import dbg

class InstructionPipeline():
    INIT = "pushl %%ebp \nmovl %%esp, %%ebp"
    
    def __init__(self):
        self.instructions = []

    def write(self, op):
        dbg.log("Writing instruction:", op)
        self.instructions.append(op)

    def export(self, fname="source.ll"):
        if fname != None:
            with open(fname, "w") as out_file:
                indent_cnt = 0
                for instruction in self.instructions:
                    # TODO: Iterate Memory Manager here
                    output = instruction.write()
                    indent_cnt -= output.count("}")
                    indent = "    " * indent_cnt
                    indent_cnt += output.count("{")
                    lines = output.split("\n")
                    lines = ("\n"+indent).join(line.strip() for line in lines if line.strip())
                    if lines:
                      out_file.write(indent + lines + "\n") 
        else:
            code = ""
            for instruction in self.instructions:
                lines = instruction.write().split("\n")
                lines = "\n".join(line.strip() for line in lines if line.strip())
                code += lines + "\n"
            return code
