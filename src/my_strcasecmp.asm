[BITS 64]
global strcasecmp:function
extern strcmp
section .text

strcasecmp:
    ret