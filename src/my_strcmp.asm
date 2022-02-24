[BITS 64]
global strcmp:function
section .text

strcmp:
    enter 0, 0
    cmp rdi, 0 ; check if s1 is NULL
    je null_end ;
    cmp rsi, 0 ; check if s2 is NULL
    je null_end ;
loop:
    cmp rdi, 0 ; check if s1 is NULL
    je string_end ;
    cmp rsi, 0 ; check if s2 is NULL
    je string_end ;
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
    jmp loop
end:
    movzx rax, r8b ; cuz of partial registers we need to extend r8b to r8
    movzx r10, r9b ; same here
    sub rax, r10 ; compute difference
    leave
    ret
null_end:
    xor rax, rax ; return 0
    leave
    ret
string_end:
    mov r8b, byte[rdi]
    mov r9b, byte[rsi]
    sub r8b, r9b
    movzx rax, r8b