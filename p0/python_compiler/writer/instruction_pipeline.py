from ..debug import dbg

class InstructionPipeline():
    INIT = "pushl %%ebp \nmovl %%esp, %%ebp"
    
    def __init__(self):
        self.instructions = []

    def write(self, op):
        dbg.log("Writing instruction:", op)
        self.instructions.append(op)

    def export(self):
        with open("source.s", "w") as out_file:
            for instruction in self.instructions:
                out_file.write(instruction.write() + "\n") 
