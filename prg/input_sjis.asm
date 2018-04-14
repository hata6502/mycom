#include "init.asm"

// variable declaration
#define greg_0 192
#define greg_1 193

#define i	194
#define j	195

// function declaration
#define print(str, offset, return) push(return); push(offset); push(str); goto(print); return:

str:	"BlueHood Computer    version: 1.0";
str_2:	"ÊÝ¶¸¶Å¦ ÄÞ³Æ­³¼À¡ ¶Ý¼Þ¶Þ Â¶´Å²ÉÃÞ¤ ½Íß°½¦ ¸·ÞÙÉ¶Þ Ñ½Þ¶¼²¡ ";
str_ast: "*";

main:
	print(str, 1024, return);
	print(str_2, 1232, return_2);
	wait:
		goto(wait);

// print function
print:
	read *sp;
	write rr_0;
rr_0:	nop;
	write greg_0;
	read *sp;
	write rr_1;
rr_1:	nop;
	write greg_1;

print_loop:
	read *greg_0;
	write rr_2;
rr_2:   nop;
        eq 0;
        branch break;
                read *greg_0;
                write rr_3;
        rr_3:   nop;
                write *greg_1;
                read *greg_0;
                add 1;
                write greg_0;
                read *greg_1;
                add 1;
                write greg_1;
	goto(print_loop);

break:
	read *sp;
	write rr_4;
rr_4:	nop;
	write pc;

