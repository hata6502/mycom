all: c asm input

c: c.y c.l
	bison -d c.y
	flex c.l
	cc -o c lex.yy.c c.tab.c -lfl -ly -lm -DYYERROR_VERBOSE

asm: asm.y asm.l
	bison -d asm.y
	flex asm.l
	cc -o asm lex.yy.c asm.tab.c -lfl -ly -lm -DYYERROR_VERBOSE

input: init.m4 input.m4
	m4 input.m4 > input.asm
	iconv input.asm -f utf8 -t sjis > input_sjis.asm
	./asm < input_sjis.asm
