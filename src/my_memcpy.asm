[BITS 64]
global memcpy:function
section .text

memcpy:
    enter 0, 0
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