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
    cmp [rdi + rcx], sil; compare str[0 + rcx] with the c
    je found
    cmp byte[rdi + rcx], 0; check if we reached the end of the string
    dec rcx ; decrease the counter
    jmp loop

found:
    add rdi, rcx ; add the offset to the string
    mov rax, rdi ; return the pointer to the found character
    leave
    ret

not_found:
    mov rax,0 ;  return NULL
    leave
    ret