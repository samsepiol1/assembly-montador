.globl _start
.text
_start:
    mov $60, %RAX
    xor %rdi, %rdi
    syscall