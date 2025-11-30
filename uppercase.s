# vim: set filetype=arm64asm:

#define CASE_OFFSET ('a' - 'A')

  .globl _main
  .p2align 2

_main:
  ; save frame pointer (x29) and link register (x30) to the stack
    stp   x29, x30, [sp, #-16]!
    mov   x29, sp 

    mov   w20, 'a'
    mov   w21, 'z'
loop:
    bl    _getchar
    cmp   w0, #0
    b.lt  exit
    cmp   w0, w20
    b.hs  check_upper
put:
    bl    _putchar
    b     loop
check_upper:
    cmp   w0, w21
    b.ls  lowercase
    b     put
lowercase:
    sub   w0, w0, #CASE_OFFSET
    b     put

exit:
  ; restore FP and LR, move SP 16 bytes
    ldp   x29, x30, [sp], #16
    ret
