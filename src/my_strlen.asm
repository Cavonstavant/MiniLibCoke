[BITS 64]
global strlen:function
section .text

strlen:
    enter 0, 0
    pushf
    mov rbx, rdi
    xor al, al
    mov rcx, 0xffffffffffffffff
    cld
    repne scasb
    sub rdi, rbx
    sub rdi, 1
    mov rax, rdi
    popf
    leave
    ret