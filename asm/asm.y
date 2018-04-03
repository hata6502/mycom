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
Label ref_list[256] = {};
Label *ref = ref_list;

const char *instruction[] = {
	"IS_WRITE", "IS_READ", "IS_ADD", "IS_SUB", "IS_MUL", "IS_DIV", "IS_AND", "IS_OR", "IS_XOR", "IS_BRANCH", "IS_EQ", "IS_NEQ", "IS_LT", "IS_LTE", "IS_GT", "IS_GTE", 
};

int is_ref = 0;
%}

%union {
	int ival;
	double fval;
	char cval;
	char sval[32];
}

%token nl is_nop is_read is_write is_add is_sub is_mul is_div is_branch is_eq is_neq is_lt is_lte is_gt is_gte sharp ast is_and is_or is_xor
%token <sval> identifier
%token <ival> integer

%type <ival> instruction operand val inst_sentence

%%
asm	: line
	| line asm
	;

line	: line_sentence
	| ast identifier {add_label($2, PRG_ORG + addr - prg); }
	;

line_sentence	: inst_sentence nl
	| nl
	;

inst_sentence	: instruction	{*(addr++) = $$; }

instruction	: is_nop	{$$ = (2<<24) + 0; }
	| is_write operand	{$$ = (0<<24) + $2; }
	| is_read operand	{$$ = (1<<24) + $2; }

	| is_add operand	{$$ = (2<<24) + $2; }
	| is_sub operand	{$$ = (3<<24) + $2; }
	| is_mul operand	{$$ = (4<<24) + $2; }
	| is_div operand	{$$ = (5<<24) + $2; }
	| is_and operand	{$$ = (6<<24) + $2; }
	| is_or operand	{$$ = (7<<24) + $2; }
	| is_xor operand	{$$ = (8<<24) + $2; }


	| is_branch operand	{$$ = (9<<24) + $2; }
	| is_eq operand	{$$ = (10<<24) + $2; }
	| is_neq operand	{$$ = (11<<24) + $2; }
	| is_lt operand	{$$ = (12<<24) + $2; }
	| is_lte operand	{$$ = (13<<24) + $2; }
	| is_gt operand	{$$ = (14<<24) + $2; }
	| is_gte operand	{$$ = (15<<24) + $2; }
	;

operand	: val	{$$ = $1; ref_addr(addr - prg); }
	| sharp val	{*(--imm_addr) = $2; $$ = PRG_ORG + imm_addr - prg; ref_addr(imm_addr - prg); }
	;

val	: integer	{$$ = $1; }
	| instruction
	| identifier	{$$ = ref_label($1, 128); }
	;
%%

int main(void)
{
    yyparse();

	for(int *code = prg; code != &prg[PRG_SIZE]; code++){
		//printf("%08x", *code);
		if (code < addr){
			printf("is_word(%s, %d)", instruction[(*code)>>24], (*code)&((1<<24) - 1));
		}else{
			printf("%d", *code);
		}
		if (code != &prg[PRG_SIZE - 1]) printf(", ");
		if ((code - prg)%8 == 7) printf("\n");
	}

	/*printf("ラベル\n");
	for(Label *i = label_list; i != label; i++){
		printf("%s -> %d\n", i->name, i->addr);
	}
	printf("\nラベル参照\n");
	for(Label *i = ref_list; i != ref; i++){
		printf("%s -> %d\n", i->name, i->addr);
	}*/
    return 0;
}

void add_label(char *name, int addr){
	for(Label *i = ref_list; i != ref; i++){
		if (strcmp(name, i->name) == 0){
			prg[i->addr] += addr;
			i->addr = -1;
		}
	}

	label->addr = addr;
	strcpy(label->name, name);
	label++;
}

void ref_addr(int addr){
	if (is_ref){
		ref->addr = addr;
		ref++;
		is_ref = 0;
	}
}

int ref_label(char *name){
	for(Label *i = label_list; i != label; i++){
		if (strcmp(name, i->name) == 0) return i->addr;
	}
	strcpy(ref->name, name);
	is_ref = 1;

	return 0;
}
