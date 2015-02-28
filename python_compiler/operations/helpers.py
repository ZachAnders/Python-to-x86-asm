"""
    X86 assembly related helper functions.

"""

def call_func_asm(funcname, arguments=None, output=None):
    if output != None:
        write_output = "movl %eax, {output}\n".format(output=output)
    else:
        write_output = ""

    argtext = "\n".join(['pushl ' + arg for arg in arguments or []])
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
