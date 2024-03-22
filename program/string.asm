	read #str
	write #128
	read #1024
	write #129

*loop
	read 128
	add #read 0
	write #rr_1
*rr_1	nop
	eq #0
	branch #break
		read 128
		add #read 0
		write #rr_2
	*rr_2	nop
		write 129
		read 128
		add #1
		write #128
		read 129
		add #1
		write #129
	read #loop
	write #0
*break
*end
	read #end
	write #0

*str	"Orange Computer -- String Test -- FPGA de CPU tukutte, yacc de Assembler wo tukutta. String wo Display surunomo taihen datta! "
