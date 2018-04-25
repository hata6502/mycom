%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define PRG_ORG 2048
#define PRG_SIZE 1024

extern int yylineno;

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
	"IS_READ", "IS_WRITE", "IS_ADD", "IS_SUB", "IS_MUL", "IS_DIV", "IS_AND", "IS_OR", "IS_XOR", "IS_BRANCH", "IS_EQ", "IS_NEQ", "IS_LT", "IS_LTE", "IS_GT", "IS_GTE", 
};

int is_ref = 0;
%}

%union {
	int ival;
	double fval;
	char cval;
	unsigned char sval[256];
}

%token semicolon is_nop is_read is_write is_add is_sub is_mul is_div is_branch is_eq is_neq is_lt is_lte is_gt is_gte sharp ast is_and is_or is_xor colon amp
%token <sval> identifier string
%token <ival> integer

%type <ival> instruction operand val inst_sentence

%%
asm	: line
	| line asm
	;

line	: line_sentence
	| identifier colon {add_label($1, PRG_ORG + addr - prg); }
	;

line_sentence	: inst_sentence semicolon
	| semicolon
	;

inst_sentence	: instruction	{*(addr++) = $1; }
	| val	{*(addr++) = $1; }
	| string	{
		unsigned char *str = $1;
		while(*str){
			*(addr++) = *str;
			str++;
		}
		*(addr++) = '\0';
	}
	;

instruction : is_read operand	{$$ = (0<<16) + $2; }
	| is_write operand	{$$ = (1<<16) + $2; }

	| is_add operand	{$$ = (2<<16) + $2; }
	| is_sub operand	{$$ = (3<<16) + $2; }
	| is_mul operand	{$$ = (4<<16) + $2; }
	| is_div operand	{$$ = (5<<16) + $2; }
	| is_and operand	{$$ = (6<<16) + $2; }
	| is_or operand	{$$ = (7<<16) + $2; }
	| is_xor operand	{$$ = (8<<16) + $2; }

	| is_branch operand	{$$ = (9<<16) + $2; }
	| is_eq operand	{$$ = (10<<16) + $2; }
	| is_neq operand	{$$ = (11<<16) + $2; }
	| is_lt operand	{$$ = (12<<16) + $2; }
	| is_lte operand	{$$ = (13<<16) + $2; }
	| is_gt operand	{$$ = (14<<16) + $2; }
	| is_gte operand	{$$ = (15<<16) + $2; }
	;

operand	: ast val	{$$ = $2; ref_addr(addr - prg); }
	| val	{*(--imm_addr) = $1; $$ = PRG_ORG + imm_addr - prg; ref_addr(imm_addr - prg); }
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
		/*if (code < addr){
			printf("is_word(%s, %d)", instruction[(*code)>>16], (*code)&((1<<16) - 1));
		}else{
			printf("%d", *code);
		}*/
		fwrite(code, sizeof(int), 1, stdout);
		//if (code != &prg[PRG_SIZE - 1]) printf(", ");
		//printf("\t-- %d\n", code - prg + PRG_ORG);
	}

	/*printf("ラベル\n");
	for(Label *i = label_list; i != label; i++){
		printf("%s -> %d\n", i->name, i->addr);
	}
	printf("\nラベル参照\n");
	for(Label *i = ref_list; i != ref; i++){
		printf("%s -> %d\n", i->name, i->addr);
	}*/
	for(Label *i = ref_list; i != ref; i++){
		if (i->addr != -1){
			fprintf(stderr,"未解決のラベル %s\n", i->name);
			exit(1);
		}
	}
    return 0;
}

void yyerror(const char *str)
{
	fprintf(stderr,"line %d: %s\n",yylineno,str);
	exit(1);
}

void add_label(char *name, int addr){
	for(Label *i = label_list; i != label; i++){
		if (strcmp(i->name, name) == 0){
			fprintf(stderr,"line %d: ラベル 2 重定義 %s\n",yylineno, name);
			exit(1);
		}
	}

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
