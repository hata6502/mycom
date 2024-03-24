include(`init.m4')

title_str: "mugyuu";

main:
	call(print, 1244, title_str);
	goto(main);

print:
	locals(`vram_pointer', `str_pointer');
	arguments(`position', `str');

	sread(position);
	swrite(vram_pointer);
	sread(str);
	swrite(str_pointer);

	print_char_loop:
		sread(str_pointer);
		inread;
		write *autosp;
		eq 0;
		branch print_char_break;
		read *autosp;
		inread;
		inwrite(sread(vram_pointer); );

		sread(str_pointer);
		add 1;
		swrite(str_pointer);
		sread(vram_pointer);
		add 1;
		swrite(vram_pointer);
		goto(print_char_loop);
	print_char_break:
	read *autosp;
	
	return;
