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

%token void_t bopen bclose cbopen cbclose static_t int_t semi write_o while_s eq_o plus_o neq_o sbopen sbclose ast
%token <sval> identifier
%token <ival> integer

%type <sval> val sentence usentence msentence wsentence sentences esentence w_obj

%%

function	: void_t identifier bopen bclose msentence{
			int i;
			for(i = 0; i<16; i++) printf("nop\n");
			printf($5);
		}
		;

sentences	: sentence {strcpy($$, $1); }
		| sentence sentences {sprintf($$, "%s%s", $1, $2); }
		;

// 文
sentence	: usentence { strcpy($$, $1); }
		| msentence { strcpy($$, $1); }
		| wsentence { strcpy($$, $1); }
		| esentence { strcpy($$, $1); }
		;

// 空文
esentence	: semi { sprintf($$, ""); }
		;

// 単文
usentence	: val semi {strcpy($$, $1); }
		;

// 複文
msentence	: cbopen vdecs sentences cbclose {strcpy($$, $3); }
		| cbopen sentences cbclose {strcpy($$, $2); }
		;

// while 文
wsentence	: while_s bopen val bclose sentence{
			sprintf($$, "*while_%d\n%seq #0\nbranch #wbreak_%d\n%sread #while_%d\nwrite #0\n*wbreak_%d\n", label_i, $3, label_i, $5, label_i, label_i);
			label_i++;
		};


// 変数定義リスト
vdecs	: vdec
	| vdec vdecs;

// 変数定義
vdec	: static_t int_t identifier semi {
		strcpy(vars[vars_i].name, $3);
		vars[vars_i].addr = vars_i + VAR_ORG;
		vars_i++;
	}
	;

// 値
val	: identifier {
		Var *var;
		var = search_var($1);

		sprintf($$, "read %d\n", var->addr);
	}
	| integer {
		sprintf($$, "read #%d\n", $1);
	}
	| w_obj write_o val {
		Var *var;
		var = search_var($1);

		sprintf($$, "%s%s\n", $3, $1);
	}
	| w_obj eq_o val {
		sprintf($$, "%swrite 2\nread 2\nadd #eq 0\nwrite #rr_%d\n%s*rr_%d nop\n", $3, label_i, $1, label_i);
		label_i++;
	}
	| val neq_o val {
		sprintf($$, "%swrite 2\nread 2\nadd #neq 0\nwrite #rr_%d\n%s*rr_%d nop\n", $3, label_i, $1, label_i);
		label_i++;
	}
	| val plus_o val {
		sprintf($$, "%swrite 2\nread 2\nadd #add 0\nwrite #rr_%d\n%s*rr_%d nop\n", $3, label_i, $1, label_i);
		label_i++;
	}
	| val ast val {
		sprintf($$, "%swrite 2\nread 2\nadd #mul 0\nwrite #rr_%d\n%s*rr_%d nop\n", $3, label_i, $1, label_i);
		label_i++;
	}
	;

// 代入可能オブジェクト
w_obj	: identifier {
		Var *var;
		var = search_var($1);
		sprintf($$, "write #%d\n", var->addr);
	}
	| val sbopen val sbclose {
		sprintf($$, "write 2\n%swrite 2\nread 2\nadd #add 0\nwrite #rr_%d\n%s\n*rr_%d nop\nadd #write 0\nwrite #128\nread 2\nwrite #rw_%d\n*rw_%d nop\nwrite 128\n", $1, label_i, $3, label_i, label_i, label_i); 
		label_i++;
	}
	;

%%

int main(void)
{
    yyparse();
}
