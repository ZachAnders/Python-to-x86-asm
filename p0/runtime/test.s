.globl main
main:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp
    call input
    negl %eax
    movl %eax, -4(%ebp)
    call input
    addl -4(%ebp), %eax
    pushl %eax
    call print_int_nl
    addl $4, %esp
    movl $0, %eax
    leave
    ret
