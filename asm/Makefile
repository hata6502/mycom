all: asm.tab.c lex.yy.c
	cc -o asm lex.yy.c asm.tab.c -lfl -ly -lm

asm.tab.c: asm.l
	bison -d asm.y

lex.yy.c:
	flex asm.l

clean:
	rm asm asm.tab.c lex.yy.c asm.tab.h

