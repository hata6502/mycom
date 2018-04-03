%{
#include "asm.tab.h"
#include <string.h>
%}

white       [ \t]
comment	--.*\n
identifier      [a-zA-Z_][0-9a-zA-Z_]*
integer	[0-9]+
other       .

%%
{white}	{}
{comment}	{}

nop	{return(is_nop); }
read	{return(is_read); }
write	{return(is_write); }
add	{return(is_add); }
sub	{return(is_sub); }
mul	{return(is_mul); }
div	{return(is_div); }
and	{return(is_and); }
or	{return(is_or); }
xor	{return(is_xor); }
branch	{return(is_branch); }
eq	{return(is_eq); }
neq	{return(is_neq); }
lt	{return(is_lt); }
lte	{return(is_lte); }
gt	{return(is_gt); }
gte	{return(is_gte); }

{integer}	{yylval.ival = atoi(yytext); return(integer); }
{identifier}	{strcpy(yylval.sval, yytext); return(identifier); }
#	{return(sharp); }
\*	{return(ast); }
\n	{return(nl); }

{other}                 { fprintf(stderr, "Illegal charcter %c, ignored\n", yytext[0]); }
%%
