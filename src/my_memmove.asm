[BITS 64]
global memmove:function
section .text

memmove:
    enter 0, 0
    cmp rdi, 0
    je end
    cmp rsi, 0
    je end
    cmp rdx, 0
    je end
    xor rcx, rcx ; init checks
loop:
    cmp rdx, rcx ; check if we are done
    je end ; if yes jump
    mov r8b, byte[rsi + rcx] ; cpy byte from src to temp register
    mov byte[rdi + rcx], r8b ; cpy temp byte to dest
    inc rcx ; else increment
    jmp loop ; jump to loop
end:
    mov rax, rdi
    leave