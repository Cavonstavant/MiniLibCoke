[BITS 64]
global memset:function
section .text

memset:
    enter 0, 0
loop:
    cmp rdi, 0
    je end
    mov [rdi + rdx], sil ; else write to memory
    cmp rdx, 0 ; check if we are done
    je end ; if yes jump
    ; inc rdi ; in crement offset
    dec rdx ; increment temp count
    jmp loop ; loop

end:
    mov rax, rdi
    leave
    ret