[BITS 64]
global strcspn:function
extern strpbrk
extern strlen
section .text

strcspn:
    enter 0, 0
    cmp rdi, 0
    je .end
    cmp rsi, 0
    je .end
    push rdi
    push rsi
    call strpbrk wrt ..plt
    pop rsi
    pop rdi
    cmp rax, 0
    je .not_found
    sub rax, rdi
    leave
    ret
.not_found:
    call strlen wrt ..plt
    leave
    ret
.end:
    mov rax, rcx
    leave
    ret