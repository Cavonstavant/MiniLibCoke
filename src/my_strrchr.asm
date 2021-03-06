[BITS 64]
global strrchr:function
global rindex:function
extern strlen
section .text

rindex:

strrchr:
    enter 0,0
    cmp rdi, 0 ; check if the string is NULL / empty
    je not_found
    call strlen wrt ..plt
    mov r8, rax

loop:
    cmp byte[rdi + r8], sil; compare str[0 + r8] with the c
    je found ; if yes jump
    cmp byte[rdi + r8], 0; check if we reached the end of the string
    je not_found ; if yes jump
    dec r8; decrease the counter
    jmp loop

found:
    lea rax, [rdi + r8] ; return the pointer to the found character
    leave
    ret

not_found:
    mov rax, 0 ;  return NULL
    leave
    ret