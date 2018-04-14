#define pc 0
#define wreg 1
#define sp 2
#define rand 3

#define nop add *3
#define goto(val) read val; \
	write pc
#define push(val) read val; \
        write *sp

	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	nop;
	goto(main);
