%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define PRG_SIZE 256
#define PRG_ORG 256

int prg[PRG_SIZE] = {};
int *addr = prg;
int *imm_addr = &prg[PRG_SIZE];

typedef struct{
	char name[32];
	int addr;
} Label;
Label label_list[256] = {};
Label *label = label_list;

%}

%union {
	int ival;
	double fval;
	char cval;
	char sval[32];
}

%token nl is_nop is_read is_write is_add is_sub is_mul is_div is_branch is_eq is_neq is_lt is_lte is_gt is_gte sharp ast
%token <sval> identifier
%token <ival> integer

%type <ival> instruction operand val inst_sentence

%%
asm	: line
	| line asm
	;

line	: line_sentence
	| ast identifier line_sentence	{label->addr = addr - prg; strcpy(label->name, $2); label++; }
	;

line_sentence	: inst_sentence nl
	| nl
	;

inst_sentence	: instruction	{*(addr++) = $$; }

instruction	: is_nop	{$$ = 0; }
	| is_read operand	{$$ = 0 + $2; }
	| is_write operand	{$$ = (1<<24) + $2; }
	;

operand	: val	{$$ = $1; }
	| sharp val	{*(--imm_addr) = $2; $$ = PRG_ORG + imm_addr - prg; }
	;

val	: integer	{$$ = $1; }
	| instruction
	| identifier	{$$ = find_label($1); }
	;
%%

int main(void)
{
    yyparse();

	for(addr = prg; addr != &prg[PRG_SIZE]; addr++){
		printf("%08x ", *addr);
		if ((addr - prg)%16 == 15) printf("\n");
	}

	for(Label *i = label_list; i != label; i++){
		printf("%s -> %d\n", i->name, i->addr);
	}
    return 0;
}

int find_label(char *name){
	for(Label *i = label_list; i != label; i++){
		if (strcmp(name, i->name) == 0) return i->addr;
	}
	fprintf(stderr, "Couldn't resolve the label address. \"%s\"\n", name);
	return 0;
}
