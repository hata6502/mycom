all: asm main

c: c.y c.l
	bison -d c.y
	flex c.l
	cc -o c lex.yy.c c.tab.c -lfl -ly -lm -DYYERROR_VERBOSE

asm: asm.y asm.l
	bison -d asm.y
	flex asm.l
	cc -o asm lex.yy.c asm.tab.c -lfl -ly -lm -DYYERROR_VERBOSE

main: init.m4 main.m4
	m4 main.m4 > main.asm
	iconv main.asm -f utf8 -t sjis > main_sjis.asm
	./asm < main_sjis.asm > boot.txt
