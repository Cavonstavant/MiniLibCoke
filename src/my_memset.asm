[BITS 64]
global memset:function
section .text

memset:
    enter 0, 0
loop:
    cmp rcx, 0 ; check if we are done
    je end ; if yes jump
    mov [rdi], sil ; else write to memory
    inc rdi ; increment offset
    dec rcx ; decrement count
    jmp loop ; loop

end:
    mov rax, rdi
    leave
    ret