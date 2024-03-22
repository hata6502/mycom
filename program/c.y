%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

typedef struct{
	char name[32];
	int addr;
} Var;
Var vars[256];
int vars_i = 0;
#define VAR_ORG 192

int label_i = 0;

Var *search_var(const char *name){
	int i;
	for(i = 0; i < vars_i; i++){
		if (strcmp(vars[i].name, name) == 0) return &vars[i];
	}
	return NULL;
}

%}

%union {
	int ival;
	char sval[1024];
}

%token auto_s register_s static_s extern_s typedef_s
%token void_t char_t short_t int_t long_t float_t double_t signed_t unsigned_t struct_t union_t
%token const_q volatile_q
%token if_s else_s switch_s while_s do_s for_s goto_s continue_s break_s return_s 
%token cbopen cbclose comma colon sbopen sbclose bopen bclose etc semicolon 
%token condition_o boolor_o booland_o or_o xor_o and_o eq_o neq_o lt_o gt_o lte_o gte_o lshift_o rshift_o 
%token plus_o minus_o ast div_o mod_o inc_o dec_o sizeof_o ref_o rref_o 
%token write_o mulw_o divw_o modw_o addw_o subw_o lshiftw_o rshiftw_o andw_o xorw_o orw_o compw_o invw_o

%token <sval> identifier
%token <ival> integer

%%
c	: 
	| external-declarations;

external-declarations	: external-declaration
			| external-declaration external-declarations
			;

external-declaration	: function-definition;

function-definition	: declarator compound-statement
			| declaration-specifiers declarator compound-statement
			| declarator declarations compound-statement
			| declaration-specifiers declarator declarations compound-statement
			;

declaration-specifiers	: declaration-specifier
			| declaration-specifier declaration-specifiers
			;

declaration-specifier	: storage-class-specifier
			| type-specifier
			| type-qualifier
			;

storage-class-specifier	: static_s
			;

type-specifier	: void_t
		| int_t
		;

type-qualifier	: const_q
		| volatile_q
		;

declarator	: direct-declarator
		;

direct-declarator	: identifier
			| bopen declarator bclose
			| direct-declarator bopen bclose
		;

declarations	: declaration
		| declaration declarations
		;

declaration	: declaration-specifiers semicolon
		| declaration-specifiers init-declarators semicolon
		;

init-declarators	: init-declarator
			| init-declarator init-declarators
			;

init-declarator	: declarator;

/*parameter-type-list	: parameter-list
			| parameter-list comma etc
			;*/

/*parameter-list	: parameter-declaration
		| parameter-list comma parameter-declaration
		;*/

/*parameter-declaration	: declaration-specifiers declarator
			| declaration-specifiers
			;*/

compound-statement	: cbopen declarations statements cbclose
			| cbopen declarations cbclose
			| cbopen statements cbclose
			| cbopen cbclose
			;

statements	: statement
		| statement statements
		;

statement	: compound-statement
		| expression-statement
		;

expression-statement	: expression semicolon
			| semicolon
			;

expression	: assignment-expression;

assignment-expression	: conditional-expression
			| unary-expression assignment-operator assignment-expression
			;

conditional-expression	: logical-or-expression
			;

logical-or-expression	: logical-and-expression
			;

logical-and-expression	: inclusive-or-expression
			;

inclusive-or-expression	: exclusive-or-expression
			;

exclusive-or-expression	: and-expression
			;

and-expression	: equality-expression
		;

equality-expression	: relational-expression
			;

relational-expression	: shift-expression
			;

shift-expression	: additive-expression
			;

additive-expression	: multiplicative-expression
			;

multiplicative-expression	: cast-expression
				;

cast-expression	: unary-expression
		;

unary-expression	: postfix-expression
			;

postfix-expression	: primary-expression
			;

primary-expression	: identifier
			| constant
			;

constant	: integer
		;

assignment-operator	: write_o
			;


%%

int main(void)
{
    yyparse();
}
