all: c asm

c: c.y c.l
	bison -d c.y
	flex c.l
	cc -o c lex.yy.c c.tab.c -lfl -ly -lm -DYYERROR_VERBOSE

asm: asm.y asm.l
	bison -d asm.y
	flex asm.l
	cc -o asm lex.yy.c asm.tab.c -lfl -ly -lm -DYYERROR_VERBOSE
