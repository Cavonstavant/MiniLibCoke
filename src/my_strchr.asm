[BITS 64]
global strchr:function
global index:function
section .text

index:
strchr:
    enter 0,0
    cmp rdi, 0 ; check if the string is NULL / empty
    je not_found
loop:
    cmp byte[rdi], sil; compare str[rdi] with c
    je found ; if equal, jump to found
    cmp byte[rdi], 0; check if we reached the end of the string
    je not_found ; if yes, jump
    inc rdi ; increase the offset
    jmp loop

found:
    mov rax, rdi ; return the pointer to the found character
    leave
    ret

not_found:
    mov rax, 0 ;  return NULL
    leave
    ret
