"""
    X86 assembly related helper functions.

"""

def CONST(val, tag=None):
    tag_value = 0
    if tag == None:
        return "$" + str(val)
    elif tag == "INT":
        tag_value = 0
    elif tag == "BOOL":
        tag_value = 1
    elif tag == "FLOAT":
        tag_value = 2
    elif tag == "BIG":
        tag_value = 3
        
    return "$" + str( (val << 2) | tag_value )

def call_func_asm(funcname, arguments=None, output=None):
    """
        funcname: Name of function (String)
        arguments: List of allocations (List(Allocation))
        output: Function return destination (Allocation)
    """
    if arguments == None:
        arguments = []
    if output != None:
        write_output = "movl %eax, {output}\n".format(output=output)
    else:
        write_output = ""

    assert isinstance(arguments, list), "Arguments must be lists, not " + str(type(arguments))

    arguments.reverse()

    argtext = "\n".join(['pushl ' + str(arg) for arg in arguments or []])
    popargs = "addl ${num}, %esp".format(num=len(arguments)*4)

    return """
    pushl %ebx # Save caller save registers
    pushl %ecx
    pushl %edx
    {argtext}
    call {funcname} # Call function
    {popargs}
    popl %edx # Restore Caller save registers
    popl %ecx
    popl %ebx
    {write_output}
    """.format(
            funcname=funcname,
            argtext=argtext,
            popargs=popargs,
            write_output=write_output
            )

def if_branch_asm(condition, branch1, branch2):
    """
        condition: Location of boolean result
        branch1: Assembly Instructions (String)
        branch2: Assembly Instructions (String)
    """

    """

 >>>>    result1 = exec e1
    if result1 == False jump .set_false
 >>>>    result2 = exec e2
        result3 = result2
        jmp .end

    .set_false
    result3 = result1
    jmp .end

    .end
   


#    if result2 == True jump .set_end

"""

"""

and = ConditionalDispatcher(dispatcher, set_true=OpMovl(...), set_false=OpMovl(...))

"""

#class ConditionalDispatcher(object):
#    def __init__(self, dispatcher, **astnodes):
#        self.astnodes = astnodes
#        self.instr = instructionPipeline

class __LabelManager__(object):
    def __init__(self):
        self.labels = {}

    def newLabel(self, name):
        if name not in self.labels:
            self.labels[name] = 0

        next_label = name + "_" + str(self.labels[name])
        self.labels[name] += 1

        return next_label

LabelManager = __LabelManager__()
