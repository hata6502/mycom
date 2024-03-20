/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_ASM_TAB_H_INCLUDED
# define YY_YY_ASM_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    semicolon = 258,               /* semicolon  */
    is_read = 259,                 /* is_read  */
    is_write = 260,                /* is_write  */
    is_add = 261,                  /* is_add  */
    is_sub = 262,                  /* is_sub  */
    is_mul = 263,                  /* is_mul  */
    is_div = 264,                  /* is_div  */
    is_branch = 265,               /* is_branch  */
    is_eq = 266,                   /* is_eq  */
    is_neq = 267,                  /* is_neq  */
    is_lt = 268,                   /* is_lt  */
    is_lte = 269,                  /* is_lte  */
    is_gt = 270,                   /* is_gt  */
    is_gte = 271,                  /* is_gte  */
    sharp = 272,                   /* sharp  */
    ast = 273,                     /* ast  */
    is_and = 274,                  /* is_and  */
    is_or = 275,                   /* is_or  */
    is_xor = 276,                  /* is_xor  */
    colon = 277,                   /* colon  */
    amp = 278,                     /* amp  */
    identifier = 279,              /* identifier  */
    string = 280,                  /* string  */
    integer = 281                  /* integer  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 31 "asm.y"

	int ival;
	double fval;
	char cval;
	unsigned char sval[256];

#line 97 "asm.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_ASM_TAB_H_INCLUDED  */
