%{
#include "c.tab.h"
#include <string.h>
%}

white       [ \t]
identifier      [a-zA-Z_][0-9a-zA-Z_]*
integer	[0-9]+
string \".*\"
other       .

%%
auto	{return(auto_s); }
register	{return(register_s); }
static	{return(static_s); }
extern	{return(extern_s); }
typedef	{return(typedef_s); }

void	{return(void_t); }
char	{return(char_t); }
short	{return(short_t); }
int	{return(int_t); }
long	{return(long_t); }
float	{return(float_t); }
double	{return(double_t); }
signed	{return(signed_t); }
unsigned	{return(unsigned_t); }
struct	{return(struct_t); }
union	{return(union_t); }

const	{return(const_q); }
volatile	{return(volatile_q); }

if	{return(if_s); }
else	{return(else_s); }
switch	{return(switch_s); }
while	{return(while_s); }
do	{return(do_s); }
for	{return(for_s); }
goto	{return(goto_s); }
continue	{return(continue_s); }
break	{return(break_s); }
return	{return(return_s); }

\{	{return(cbopen); }
\}	{return(cbclose); }
\,	{return(comma); }
\:	{return(colon); }
\[	{return(sbopen); }
\]	{return(sbclose); }
\(	{return(bopen); }
\)	{return(bclose); }
\.\.\.	{return(etc); }
;	{return(semicolon); }

\<\<=	{return(lshiftw_o); }
>>=	{return(rshiftw_o); }
\*=	{return(mulw_o); }
\/=	{return(divw_o); }
%=	{return(modw_o); }
\+=	{return(addw_o); }
-=	{return(subw_o); }
&=	{return(andw_o); }
^=	{return(xorw_o); }
\|=	{return(orw_o); }
~	{return(compw_o); }
!	{return(invw_o); }
=	{return(write_o); }
\?	{return(condition_o); }
\|\|	{return(boolor_o); }
&&	{return(booland_o); }
\|	{return(or_o); }
\^	{return(xor_o); }
&	{return(and_o); }
==	{return(eq_o); }
!=	{return(neq_o); }
\<	{return(lt_o); }
>	{return(gt_o); }
\<=	{return(lte_o); }
>=	{return(gte_o); }
\<\<	{return(lshift_o); }
>>	{return(rshift_o); }
\+	{return(plus_o); }
-	{return(minus_o); }
\*	{return(ast); }
\/	{return(div_o); }
%	{return(mod_o); }
\+\+	{return(inc_o); }
--	{return(dec_o); }
sizeof	{return(sizeof_o); }
\.	{return(ref_o); }
->	{return(rref_o); }

{identifier}	{strcpy(yylval.sval, yytext); return(identifier); }
{integer}	{yylval.ival = atoi(yytext); return(integer); }
{white}	{}
{other}                 { fprintf(stderr, "Illegal charcter %c, ignored\n", yytext[0]); }
%%
