# vim: set filetype=arm64asm ts=4 sw=4:

  .globl _main
  .p2align 2

_main:
    stp   x29, x30, [sp, #-16]!
    mov   x29, sp 

    mov   w19, wzr
loop:
    cmp   w19, #5
    b.eq  exit
    add   w19, w19, #1
    adr   x0, msg
    bl    _puts
    b     loop

exit:
    ldp   x29, x30, [sp], #16
    ret

msg:    .asciz "Hello ASM!"
