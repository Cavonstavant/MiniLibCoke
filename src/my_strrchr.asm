[BITS 64]
global strrchr:function
global rindex:function
extern strlen
section .text

rindex:

strrchr:
    enter 0,0
    cmp rdi, 0 ; check if the string is NULL / empty
    jz not_found
    call strlen wrt ..plt
    mov r8, rax
    sub r8, 1

loop:
    cmp byte[rdi + r8], 0; check if we reached the end of the string
    je not_found ; if yes jump
    cmp byte[rdi + r8], sil; compare str[0 + rcx] with the c
    je found ; if yes jump
    dec r8; decrease the counter
    jmp loop

found:
    lea rax, [rdi + r8] ; return the pointer to the found character
    ; mov rax, rdi
    leave
    ret

not_found:
    mov rax, 0 ;  return NULL
    leave
    ret