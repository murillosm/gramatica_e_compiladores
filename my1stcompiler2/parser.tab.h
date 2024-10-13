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
    BOOLEAN_TYPE = 264,
    CLASS_IDENTIFIER = 265,
    IF = 266,
    ELSE = 267,
    MAP = 268,
    IDENTIFIER = 269,
    NUMBER = 270,
    FLOAT = 271,
    STRING = 272,
    TRUE = 273,
    FALSE = 274,
    CONSOLE_LOG = 275,
    CONST = 276,
    RETURN = 277,
    FUNCTION = 278,
    BOOLEAN = 279,
    ERROR = 280,
    LBRACKET = 281,
    RBRACKET = 282,
    LBRACE = 283,
    RBRACE = 284,
    LPARENTHESES = 285,
    RPARENTHESES = 286,
    COMMA = 287,
    SINGLE_QUOTE = 288,
    DOT = 289,
    DOUBLE_QUOTE = 290,
    EXP = 291,
    EQ = 292,
    BACKTICK = 293,
    DOLLAR = 294,
    ARROW = 295,
    ASYNC = 296,
    AWAIT = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 35 "parser.y" /* yacc.c:1909  */

    int yint;
    float yfloat;
    char *ystr;

#line 103 "parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
