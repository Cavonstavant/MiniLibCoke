[BITS 64]
global strncmp:function
section .text

strncmp:
    enter 0, 0
    mov rcx, rdx ; rcx = len used by  jrcxz at line 10
    cld ; clear direction flag => go left to right
.loop:
    jrcxz .eq ; if rcx is zero, we're done https://faydoc.tripod.com/cpu/jecxz.htm
    dec rcx ; decrement rcx
    cmpsb ; https://faydoc.tripod.com/cpu/cmpsb.htm no pain no gain
    jnz .not_eq ; check the comparison effectued in cmpsb
    cmp byte[rdi - 1], 0 ; check if end-of-string
    jne .loop ; loop if not
.eq:

    xor rax, rax ; if end-of-string, return 0
    leave
    ret
.not_eq:
    movzx rax, byte[rdi - 1] ; prepare s1 for sub and put it in rax
    movzx rdx, byte[rsi - 1] ; prepare s2 for sub
    sub rax, rdx ; substract s1 from s2
    leave
    ret
