[BITS 64]
global strchr:function
section .text

strchr:
    enter 0,0
    cmp rdi, 0 ; check if the string is NULL / empty
    je not_found

loop:
    cmp [rdi + rcx], sil; compare str[0 + rcx] with the c
    je found
    cmp byte[rdi + rcx], 0; check if we reached the end of the string
    inc rcx ; increase the counter
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