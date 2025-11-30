; vim: set noet ci pi sts=0 sw=8 ts=8 filetype=arm64asm:

	.globl _main
	.p2align 2

_main:
	stp	fp, lr, [sp, #-16]!
	mov	fp, sp

	mov	x19, #0
	mov	x20, #1

	; set maximum to half of largest uint64, since a sum would overflow from here
	movn	x22, #0
	movk	x22, #0x7fff, lsl #48

loop:
	; compares with maximum allowed value
	cmp	x20, x22
	b.hs	exit

	; prints out n-th fibonacci
	adrp	x0, int_format@page
	add	x0, x0, int_format@pageoff
	str	x20, [sp]
	bl	_printf

	; calculates the next
	mov	x21, x19
	mov	x19, x20
	add	x20, x20, x21
	b	loop

exit:
	adrp	x0, exit_msg@page
	add	x0, x0, exit_msg@pageoff
	bl	_puts
	mov	x0, #0

	ldp	fp, lr, [sp], #16
	ret

int_format:
	.asciz "%20llu\n"

exit_msg:
	.asciz "done!"
