#define pc 0
#define wreg 1
#define sp 2
#define rand 3

#define i2c_addr 8
#define i2c_rdata 9
#define i2c_wdata 10
#define i2c_stat 11

#define nop add 0
#define goto(val) read val; write pc
#define push(val) read val; write *sp

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
