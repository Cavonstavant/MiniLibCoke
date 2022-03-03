[BITS 64]
global memcpy:function
section .text

memcpy:
    enter 0, 0
    cmp rdi, 0
    je end
    cmp rsi, 0
    je end
    cmp rdx, 0
    je end
    xor rcx, rcx ; init checks
loop:
    mov r8b, byte[rsi + rdx] ; cpy byte from src to temp register
    mov byte[rdi + rdx], r8b ; cpy temp byte to dest
    cmp rdx, rcx ; check if we are done
    je end ; if yes jump
    inc rdx ; else increment
    jmp loop ; jump to loop
end:
    mov rax, rdi
    leave
    ret