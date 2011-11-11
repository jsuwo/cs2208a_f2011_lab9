include(macro_defs.m)

.data
msg:	.asciz	"Hello from myfadd\n"

.text

begin_fn(myfadd)

	set	msg, %o0
	call	writeString
	nop

	ret
	restore
