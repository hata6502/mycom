include(`init.m4')

define(`ireg', 129)
define(`dummy', 130)

title_str: "mugyuu";

main:
	read *dummy;
	add 1;
	write dummy;
	write ireg;
	read *ireg;	div 1000;	mod(10); add 48; write 1230;
	read *ireg;	div 0100;	mod(10); add 48; write 1231;
	read *ireg;	div 0010; mod(10); add 48; write 1232;
	read *ireg;	div 0001; mod(10); add 48; write 1233;

	call(print, title_str, 1244);
	goto(main);

print:
	locals(`local_1', `local_2');
	arguments(`str', `position');

	sread(position);
	write ireg;
	sread(str);
	write *ireg;
	
	return;
