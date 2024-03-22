#include "init.asm"

#define ins 253
#define cnt_l 254
#define cnt_h 255

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


	read 0;
	write cnt_l;
	read 2048;
	write cnt_h;
i2c_read_loop:
	read *cnt_h;
	eq 3072;
	branch i2c_read_loop_break;

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

	read *cnt_l;
	neq 0;
	branch cnt_l_0;
		read *i2c_rdata;
		write ins;

		read 1;
		write cnt_l;
		goto(cnt_l_switch);
cnt_l_0:

	read *cnt_l;
	neq 1;
	branch cnt_l_1;
		read *i2c_rdata;
		mul 256;
		add *ins;
		write ins;

		read 2;
		write cnt_l;
		goto(cnt_l_switch);

cnt_l_1:

	read *cnt_l;
	neq 2;
	branch cnt_l_2;
		read *i2c_rdata;
		mul 65536;
		add *ins;
		write ins;

		read *ins;
		write *cnt_h;
		read *cnt_h;
		add 1;
		write cnt_h;

		read 0;
		write cnt_l;
		goto(cnt_l_switch);
cnt_l_2:
cnt_l_switch:

	goto(i2c_read_loop);

i2c_read_loop_break:
	goto(2048);
