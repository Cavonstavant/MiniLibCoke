[BITS 64]
global memset:function
section .text

memset:
    enter 0, 0
    xor rcx, rcx
loop:
    cmp rcx, rdx ; check if we are done
    mov [rdi + rcx], sil ; else write to memory
    je end ; if yes jump
    inc rcx ; increment temp count
    jmp loop ; loop

end:
    mov rax, rdi
    leave
    ret