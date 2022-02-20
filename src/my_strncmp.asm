[BITS 64]
global strncmp:function
section .text

strcmp:
    enter 0, 0
loop:
    cmp rcx, 0 ; if n == 0, we're done
    je end
    mov r8b, byte[rdi] ; copy first byte of s1 to temp register
    cmp r8b, 0 ; check if it is zero
    je end
    mov r9b, byte[rsi] ; copy first byte of s2 to temp register
    cmp r9b, 0 ; check if it is zero
    je end
    cmp r8b, r9b ; compare bytes
    jne end
    inc rdi ; increment s1 pointer
    inc rsi ; increment s2 pointer
    dec rcx ; decrement counter
    jmp loop
end:
    movzx rax, r8b ; cuz of partial registers we need to extend r8b to r8
    movzx rbx, r9b ; same here
    sub rax, rbx ; compute difference
    leave
    ret
