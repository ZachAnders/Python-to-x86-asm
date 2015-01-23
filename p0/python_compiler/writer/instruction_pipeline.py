from ..debug import dbg

class InstructionPipeline():
    INIT = "pushl %%ebp \nmovl %%esp, %%ebp"
    
    def __init__(self):
        self.instructions = []

    def write(self, op):
        dbg.log("Writing instruction:", op)
        self.instructions.append(op)

    def export(self, fname="source.s"):
        if fname != None:
            with open(fname, "w") as out_file:
                for instruction in self.instructions:
                    lines = instruction.write().split("\n")
                    lines = "\n".join(line.strip() for line in lines if line.strip())
                    out_file.write(lines + "\n") 
        else:
            code = ""
            for instruction in self.instructions:
                lines = instruction.write().split("\n")
                lines = "\n".join(line.strip() for line in lines if line.strip())
                code += lines + "\n"
            return code
