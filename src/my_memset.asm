[BITS 64]
global memset:function
section .text

memset:
    enter 0, 0
    xor rcx, rcx
loop:
    cmp rcx, rdx ; check if we are done
    je end ; if yes jump
    mov [rdi + rcx], sil ; else write to memory
    inc rcx ; increment temp count
    jmp loop ; loop

end:
    mov rax, rdi
    leave
    ret