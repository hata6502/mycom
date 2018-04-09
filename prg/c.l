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
{white}	{}

while	{return(while_s); }

void	{return(void_t); }
static	{return(static_t); }
int	{return(int_t); }

{identifier}	{strcpy(yylval.sval, yytext); return(identifier); }
{integer}	{yylval.ival = atoi(yytext); return(integer); }

\(	{return(bopen); }
\)	{return(bclose); }
\{	{return(cbopen); }
\}	{return(cbclose); }
\[	{return(sbopen); }
\]	{return(sbclose); }
\;	{return(semi); }

=	{return(write_o); }
==	{return(eq_o); }
!=	{return(neq_o); }
\+	{return(plus_o); }
\*	{return(ast); }

{other}                 { fprintf(stderr, "Illegal charcter %c, ignored\n", yytext[0]); }
%%
