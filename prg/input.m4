include(`init.m4')

main:
	dnl アスキーコード'A'
	read 66;
	dnl VRAMのどこかに書き込む
	write 1240;
	goto(main);
