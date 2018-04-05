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

	read #return
	write 2
	read #1024
	write 2
	read #str
	write 2
	read #print
	write #0
*return
	read #return_2
	write 2
	read #1280
	write 2
	read #str_2
	write 2
	read #print
	write #0
*return_2
*wait
	read #wait
	write #0

*str	"TEST -- Subroutine with Hardware Stack --"
*str_2	"String wo Display suru Subroutine wo tukutta. sorosoro C Compiler wo tukuritai. "

*print
	read 2
	write #rr_0
*rr_0	nop
	write #128
	read 2
	write #rr_1
*rr_1	nop
	write #129

*print_loop
	read 128
	write #rr_2
*rr_2   nop
        eq #0
        branch #break
                read 128
                write #rr_3
        *rr_3   nop
                write 129
                read 128
                add #1
                write #128
                read 129
                add #1
                write #129
        read #print_loop
        write #0

*break
	read 2
	write #rr_4
*rr_4	nop
	write #0
