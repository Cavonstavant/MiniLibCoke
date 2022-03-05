[BITS 64]
global strstr:function
extern strncmp
extern strlen
section .text

strstr:
    enter 0, 0
    cmp rdi, 0
    je .not_found
    cmp rsi, 0
    je .not_found
    xchg rdi, rsi
    push rdi
    call strlen wrt ..plt
    mov rdx, rax
    pop rdi
    xchg rdi, rsi
    cmp rdx, 0
    jz .empty_needle
.loop:
    cmp byte[rdi], 0
    jz .not_found
    push rdi
    push rsi
    push rdx
    call strncmp wrt ..plt
    cmp rax, 0
    jz .found
    pop rdx
    pop rsi
    pop rdi
    inc rdi
    jmp .loop
.found:
    pop rdx
    pop rsi
    pop rdi
    mov rax, rdi
    leave
    ret

.not_found:
    mov rax, 0
    leave
    ret
.empty_needle:
    mov rax, rdi
    leave
    ret