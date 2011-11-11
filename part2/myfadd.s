 

.data
msg:	.asciz	"Hello from myfadd\n"

.text

.global	myfadd
myfadd:	save	%sp, -96, %sp


	set	msg, %o0
	call	writeString
	nop

	ret
	restore
