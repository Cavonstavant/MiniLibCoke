[BITS 64]
global memset:function
extern strlen
section .text

memset:
    enter 0, 0
loop:
    cmp rcx, 0
    je end
    mov [rdi], sil
    inc rdi
    dec rcx
    jmp loop

end:
    mov rax, rdi
    leave
    ret