[BITS 64]
global memset:function
section .text

memset:
    enter 0, 0
    xor rdx, rdx
loop:
    cmp rcx, 0 ; check if we are done
    je end ; if yes jump
    mov [rdi], sil ; else write to memory
    inc rdi ; increment offset
    dec rcx ; decrement count
    inc rdx;
    jmp loop ; loop

end:
    sub rdi, rdx ; subtract the offset
    mov rax, rdi
    leave
    ret