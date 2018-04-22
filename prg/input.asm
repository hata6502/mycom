#include "init.asm"

#define ptr 128

main:
	read 80;
	write i2c_addr;
i2c_wait_0:
	read *i2c_stat;
	and 4;
	branch i2c_wait_0;

i2c_wait_1:
	read 0;	// High address
	write i2c_wdata;
	read 1;
	write i2c_stat;
i2c_wait_a:
	read *i2c_stat;
	and 4;
	eq 0;
	branch i2c_wait_a;
i2c_wait_5:
	read *i2c_stat;
	and 4;
	branch i2c_wait_5;
	//read *i2c_stat;
	//and 8;
	//branch i2c_wait_1;

i2c_wait_2:
	read 0;	// Low address
	write i2c_wdata;
	read 1;
	write i2c_stat;
i2c_wait_b:
	read *i2c_stat;
	and 4;
	eq 0;
	branch i2c_wait_b;
	read 0;
	write i2c_stat;	// STOP
i2c_wait_6:
	read *i2c_stat;
	and 4;
	branch i2c_wait_6;
	//read *i2c_stat;
	//and 8;
	//branch i2c_wait_2;


	read 1024;
	write ptr;
i2c_read_loop:
i2c_wait_4:
	read 3;
	write i2c_stat;
i2c_wait_c:
	read *i2c_stat;
	and 4;
	eq 0;
	branch i2c_wait_c;
i2c_wait_3:
	read *i2c_stat;
	and 4;
	branch i2c_wait_3;
	//read *i2c_stat;
	//and 8;
	//branch i2c_wait_4;

	read *i2c_rdata;
	write *ptr;
	read *ptr;
	add 1;
	write ptr;
	goto(i2c_read_loop);
