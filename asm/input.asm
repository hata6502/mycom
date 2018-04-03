	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	read #0
	write 128
*loop
		read 128
	*ptr	write 1024
		read 128
		add #1
		write 128
		read ptr
		add #1
		write ptr

		read ptr
		neq #1536
		branch #loop

*loop
	read #wait
	write 0
