/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

#ifndef YY_YY_C_TAB_H_INCLUDED
# define YY_YY_C_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    auto_s = 258,
    register_s = 259,
    static_s = 260,
    extern_s = 261,
    typedef_s = 262,
    void_t = 263,
    char_t = 264,
    short_t = 265,
    int_t = 266,
    long_t = 267,
    float_t = 268,
    double_t = 269,
    signed_t = 270,
    unsigned_t = 271,
    struct_t = 272,
    union_t = 273,
    const_q = 274,
    volatile_q = 275,
    if_s = 276,
    else_s = 277,
    switch_s = 278,
    while_s = 279,
    do_s = 280,
    for_s = 281,
    goto_s = 282,
    continue_s = 283,
    break_s = 284,
    return_s = 285,
    cbopen = 286,
    cbclose = 287,
    comma = 288,
    colon = 289,
    sbopen = 290,
    sbclose = 291,
    bopen = 292,
    bclose = 293,
    etc = 294,
    semicolon = 295,
    condition_o = 296,
    boolor_o = 297,
    booland_o = 298,
    or_o = 299,
    xor_o = 300,
    and_o = 301,
    eq_o = 302,
    neq_o = 303,
    lt_o = 304,
    gt_o = 305,
    lte_o = 306,
    gte_o = 307,
    lshift_o = 308,
    rshift_o = 309,
    plus_o = 310,
    minus_o = 311,
    ast = 312,
    div_o = 313,
    mod_o = 314,
    inc_o = 315,
    dec_o = 316,
    sizeof_o = 317,
    ref_o = 318,
    rref_o = 319,
    write_o = 320,
    mulw_o = 321,
    divw_o = 322,
    modw_o = 323,
    addw_o = 324,
    subw_o = 325,
    lshiftw_o = 326,
    rshiftw_o = 327,
    andw_o = 328,
    xorw_o = 329,
    orw_o = 330,
    compw_o = 331,
    invw_o = 332,
    identifier = 333,
    integer = 334
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 26 "c.y" /* yacc.c:1909  */

	int ival;
	char sval[1024];

#line 139 "c.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_C_TAB_H_INCLUDED  */
