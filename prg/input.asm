#include "init.asm"

// constant declaration
#define WIDTH 39
#define WIDTH_M1 38
#define WIDTH_M2 37
#define HEIGHT 23
#define HEIGHT_M1 22
#define HEIGHT_M2 21
#define ORIGIN 1104

// variable declaration
#define greg_0	192
#define greg_1	193
#define greg_2  194
#define greg_3	195
#define i	196
#define j	197

#define makepath_ret 248
#define makepath_o 249
#define makepath_x 250
#define makepath_y 251
#define makepath_dir 252

#define sleep_cnt 253

#define print_0 254
#define print_1 255

// function declaration
#define print(str, offset, return) push(return); push(offset); push(str); goto(print); return:
#define sleep(cnt, return) push(return); push(cnt); goto(sleep); return:

#define makepath(x, y, dir, return) push(return); push(dir); push(y); push(x); goto(makepath); return:

title_str:	"BlueHood Computer  ﾒｲﾛ ｾｲｾｲ ﾌﾟﾛｸﾞﾗﾑ";
wall_str:	"ﾛ";

main:
	sleep(65536, poweron_wait);
	print(title_str, 1024, return_1);

	read 0;
	write i;
	init_loop_1:
		read *i;
		gte HEIGHT;
		branch init_break_1;

		read 0;
		write j;
		init_loop_2:
			read *j;
			gte WIDTH;
			branch init_break_2;

			read *i;
			eq 0;
			branch init_wall;
			read *i;
			eq HEIGHT_M1;
			branch init_wall;
			read *j;
			eq 0;
			branch init_wall;
			read *j;
			eq WIDTH_M1;
			branch init_wall;
			read *i;
			or *j;
			and 1;
			eq 0;
			branch init_wall;
				goto(init_blank);
		init_wall:
			read *i;
			mul 40;
			add *j;
			add ORIGIN;
			write greg_0;
			print(wall_str, *greg_0, return_2);
		init_blank:

			read *j;
			add 1;
			write j;
			goto(init_loop_2);
		init_break_2:

		read *i;
		add 1;
		write i;
		goto(init_loop_1);
	init_break_1:

	read 2;
	write i;
	top_loop:
		read *i;
		gte WIDTH_M2;
		branch top_break;

	top_loop_rerand:
		read *rand;
		and 3;
		write j;
		makepath(*i, 2, *j, return_4);
		read *makepath_ret;
		branch top_loop_rerand;
		//sleep(65536, return_6);	// 遅延

		read *i;
		add 2;
		write i;
		goto(top_loop);
	top_break:

	read 4;
	write i;
	overall_loop:
		read *i;
		gte HEIGHT_M2;
		branch overall_break;

		read 2;
		write j;
		overall_loop_2:
			read *j;
			gte WIDTH_M2;
			branch overall_break_2;

		overall_loop_2_rerand:
			read *rand;
			and 3;
			write greg_0;
			eq 0;
			branch overall_loop_2_rerand;
			makepath(*j, *i, *greg_0, return_5);
			read *makepath_ret;
			branch overall_loop_2_rerand;
			//sleep(65536, return_7);	// 遅延

			read *j;
			add 2;
			write j;
			goto(overall_loop_2);
		overall_break_2:

		read *i;
		add 2;
		write i;
		goto(overall_loop);
	overall_break:

	wait:
		goto(wait);

// makepath function
makepath:
	read *sp;
	write makepath_rr_0;
makepath_rr_0:	nop;
	write makepath_x;
	read *sp;
	write makepath_rr_1;
makepath_rr_1:	nop;
	write makepath_y;
	read *sp;
	write makepath_rr_2;
makepath_rr_2:	nop;
	write makepath_dir;

	read *makepath_y;
	mul 40;
	add *makepath_x;
	add ORIGIN;
	write makepath_o;

	read *makepath_dir;
	neq 0;
	branch makepath_up;
		read *makepath_o;
		sub 40;
		write makepath_o;
		goto(makepath_switch_break);
	makepath_up:

	read *makepath_dir;
	neq 1;
	branch makepath_down;
		read *makepath_o;
		add 40;
		write makepath_o;
		goto(makepath_switch_break);
	makepath_down:

	read *makepath_dir;
	neq 2;
	branch makepath_left;
		read *makepath_o;
		sub 1;
		write makepath_o;
		goto(makepath_switch_break);
	makepath_left:

	read *makepath_dir;
	neq 3;
	branch makepath_right;
		read *makepath_o;
		add 1;
		write makepath_o;
		goto(makepath_switch_break);
	makepath_right:

makepath_switch_break:
	read *makepath_o;
	write makepath_rr_4;
makepath_rr_4:	nop;
	//neq 0; // 219
	write makepath_ret;
	//branch makepath_test;
		print(wall_str, *makepath_o, makepath_return_0);
//makepath_test:

	read *sp;
	write makepath_rr_3;
makepath_rr_3:	nop;
	write pc;

// sleep function
sleep:
	read *sp;
	write sleep_rr_0;
sleep_rr_0:	nop;
	write sleep_cnt;

	sleep_loop_0:
		read *sleep_cnt;
		eq 0;
		branch sleep_break_0;

		read *sleep_cnt;
		sub 1;
		write sleep_cnt;
		goto(sleep_loop_0);
	sleep_break_0:

	read *sp;
	write sleep_rr_1;
sleep_rr_1:	nop;
	write pc;

// print function
print:
	read *sp;
	write print_rr_0;
print_rr_0:	nop;
	write print_0;
	read *sp;
	write print_rr_1;
print_rr_1:	nop;
	write print_1;

print_loop:
	read *print_0;
	write print_rr_2;
print_rr_2:   nop;
        eq 0;
        branch break;
                read *print_0;
                write print_rr_3;
        print_rr_3:   nop;
                write *print_1;
                read *print_0;
                add 1;
                write print_0;
                read *print_1;
                add 1;
                write print_1;
		sleep(4096, return_6);	// 遅延
	goto(print_loop);

break:
	read *sp;
	write print_rr_4;
print_rr_4:	nop;
	write pc;

