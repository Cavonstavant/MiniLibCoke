[BITS 64]
global memmove:function
section .text

memmove:
    enter 0, 0
    xor rcx, rcx ; init counter to 0
cpy:
    cmp rdx, rcx ; if rdx == rcx, we're done copying
    je loop
    mov r8b, byte[rsi + rcx] ; get the byte to copy
loop:
    cmp rdx, 0 ; check if we are done
    je end ; if yes jump
    mov r8b, byte[rsi + rdx] ; cpy byte from src to temp register
    mov byte[rdi + rdx], r8b ; cpy temp byte to dest
    dec rdx ; decrement counter
    jmp loop ; jump to loop
end:
    mov rax, rdi
    leave
    ret