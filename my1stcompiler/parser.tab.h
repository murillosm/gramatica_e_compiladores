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

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
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
    LET = 258,
    COLON = 259,
    NUMBER_TYPE = 260,
    STRING_TYPE = 261,
    ASSIGN = 262,
    SEMICOLON = 263,
    IDENTIFIER = 264,
    CLASS_IDENTIFIER = 265,
    NUMBER = 266,
    FLOAT = 267,
    STRING = 268,
    TRUE = 269,
    FALSE = 270,
    CONSOLE_LOG = 271,
    VAR = 272,
    CONST = 273,
    FLOAT_TYPE = 274,
    BOOLEAN_TYPE = 275,
    RETURN = 276,
    FUNCTION = 277,
    LBRACKET = 278,
    RBRACKET = 279,
    LBRACE = 280,
    RBRACE = 281,
    LPARENTHESES = 282,
    RPARENTHESES = 283,
    COMMA = 284,
    SINGLE_QUOTE = 285,
    ADD = 286,
    MINUS = 287,
    DOT = 288,
    DOUBLE_QUOTE = 289,
    MULT = 290,
    DIV = 291,
    EXP = 292,
    GT = 293,
    LT = 294
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 8 "parser.y" /* yacc.c:1909  */

    int yint;
    float yfloat;
    char *ystr;

#line 100 "parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
