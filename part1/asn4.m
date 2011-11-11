include(macro_defs.m)

.data
msg:	.asciz	"Hello from main\n"

.text

begin_main

	set	msg, %o0
	call	writeString
	nop

	ret
	restore
