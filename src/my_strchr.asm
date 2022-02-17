[BITS 64]
global strchr:function
section .text

strchr:
    enter 0, 0
    mov rbx, rdi
    mov rcx, rsi
    mov al, sil
    cld
    repne scasb
    je found
    mov rax, 0
    leave
    ret

found:
    add rdi, rbx
    mov rax, rdi
    leave
    ret