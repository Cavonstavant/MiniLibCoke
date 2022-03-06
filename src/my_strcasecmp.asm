[BITS 64]
global strcasecmp:function
extern strcmp
section .text

strcasecmp:
    xor rcx, rcx ; init counter
    cmp rdi, 0
    je .end
    cmp rsi, 0
    je .end
.check_str1_case:
    mov r8b, [rdi + rcx] ; get char
    cmp r8b, 65 ; str1[rcx] is uppercase
    jl .check_str2_case ; check str2[rcx]
    cmp r8b, 90 ; str1[rcx] is lowercase
    jl .check_str2_case ; check str2[rcx]
.check_str2_case:
    mov r9b, [rsi + rcx] ; get char
    cmp r9b, 65 ; str2[rcx] is uppercase
    jl .cmp
    cmp r9b, 90 ; str2[rcx] is lowercase
    jl .fix_str2_case
.cmp:
    cmp r8b, r9b ; cmp
    jne .end
    cmp r8b, 0 ; cmp if end of string
    je .end
    cmp r9b, 0 ; cmp if end of string
    je .end
    inc rcx ; inc counter
    jmp .check_str1_case
.fix_str1_case:
    add r8b, 32 ; convert to lowercase
    jmp .check_str2_case ; check str2[rcx]
.fix_str2_case:
    add r9b, 32 ; convert to lowercase
    jmp .cmp ; check str1[rcx] and str2[rcx]
.end:
    movzx rax, r8b
    movzx r9, r9b  ; return difference
    sub rax, r9
    ret