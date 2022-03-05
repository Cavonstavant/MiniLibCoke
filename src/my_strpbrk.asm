[BITS 64]
global strpbrk:function
extern strchr
section .text

strpbrk:
    enter 0, 0
    cmp rdi, 0
    je .not_found
    cmp rsi, 0
    je .not_found ; initial checks
    xor rcx, rcx
.loop: ; point of this loop is to use strchr to find the first char in rsi
    cmp byte[rdi + rcx], 0
    je .not_found
    push rdi
    push rsi
    xchg rdi, rsi ; swap rdi and rsi
    mov r8b, byte[rsi + rcx]
    movzx rsi, r8b
    call strchr wrt ..plt
    cmp rax, 0
    jne .found
    pop rdi
    pop rsi
    inc rcx
    xchg rdi, rsi
    jmp .loop
.found:
    xchg rsi, rdi
    pop rdi
    pop rsi
    mov rax, rsi
    add rax, rcx
    leave
    ret

.not_found:
    mov rax, 0
    leave
    ret