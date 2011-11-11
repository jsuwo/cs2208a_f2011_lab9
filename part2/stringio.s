! file stringio.s contains functions writeString and readString
!	
! writeString	
!   function to print a null-terminated string on the screen
!   (does not print newline at end of string)		
!   called with %o0 set to address of string
! revision history: original code 98-10
!                   revised  03-08-28
! register legend:
!	%l1:	pointer into string
	
	.global writeString
				
writeString:
	save %sp,-96,%sp

        mov  %i0, %l1            ! initialize pointer
getnext:    
        ldub  [%l1], %o0         ! get next character from string
        tst   %o0                ! if null character, done
	be    writedone
	nop	

        call writeChar           ! print the character
 	nop

        inc  %l1	         ! increment pointer
        ba   getnext		 ! go to get next character
        nop	

writedone:	
	ret
	restore


! readString	
!   function to read a string from the keyboard
!   called with %o0 set to address of byte array
!               %o1 set to size of byte array (must include room
!	            for null character at end of string)
!   returns with null-terminated string in the byte array,
!		truncated if string was too long
! revision history: written by A. Downing 98-10-30
!		    revised 00-02-24
!		    03-11-07 changed readString to flush keyboard buffer
!			if byte array fills up	
! register legend:
!	%l1:	offset into string
	
	EOL = 10		! end of line character
	
	.global readString
				
readString:
	save %sp,-96,%sp
	
	clr   %l1	        ! initialize offset into string
	deccc  %i1		! leave room for null character at end
	ble   readdone		! can't read if no room
        nop
	
putnext:
	call  readChar		! get character into %o0
	nop        
        cmp  %o0, EOL           ! is character endofline?
        be   readdone           ! if so, done
        nop	

        stb %o0, [%i0 + %l1]    ! put character into byte array

	inc  %l1                ! increment offset
	cmp  %l1, %i1		! max. no of characters already?
	bl   putnext		! if not, continue 
	nop			! (otherwise truncate)

! flush keyboard buffer to get rid of any more characters
! (including EOL) if byte array is now full
	
flush:	call readChar		! get next character
	nop
        cmp  %o0, EOL           ! is character endofline?
        bne  flush              ! if not, keep reading
        nop	
	
readdone:	
	stb   %g0, [%i0 + %l1]    ! put null character into byte array

	ret
	restore
