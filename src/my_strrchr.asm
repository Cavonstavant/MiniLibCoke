[BITS 64]
global strchr:function
extern strlen
section .text

strrchr:
    enter 0,0
    cmp rdi, 0 ; check if the string is NULL / empty
    je not_found
    push rdi
    call strlen wrt ..plt
    pop rdi
    add rcx, rax

loop:
    cmp byte[rdi], sil; compare str[0 + rcx] with the c
    je found ; if yes jump
    cmp byte[rdi], 0; check if we reached the end of the string
    je not_found ; if yes jump
    dec rdi; decrease the counter
    jmp loop

found:
    mov rax, rdi ; return the pointer to the found character
    leave
    ret

not_found:
    mov rax, 0 ;  return NULL
    leave
    ret