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
    IDENTIFIER = 258,
    STRING = 259,
    NUMBER = 260,
    LET = 261,
    VAR = 262,
    CONST = 263,
    ASSIGN = 264,
    SEMICOLON = 265,
    DOUBLE_QUOTE = 266,
    SINGLE_QUOTE = 267,
    CRASIS_QUOTE = 268,
    LPAREN = 269,
    RPAREN = 270,
    CONSOLE_LOG = 271,
    FLOAT = 272,
    TRUE = 273,
    FALSE = 274,
    BOOLEAN = 275,
    ANY_TYPE = 276,
    NUMBER_TYPE = 277,
    STRING_TYPE = 278,
    BOOLEAN_TYPE = 279,
    RETURN = 280,
    FUNCTION = 281,
    ERROR_LITERAL = 282,
    EQ = 283,
    COLON = 284,
    LBRACKET = 285,
    RBRACKET = 286,
    LBRACE = 287,
    RBRACE = 288,
    LPARENTHESES = 289,
    RPARENTHESES = 290,
    COMMA = 291,
    MINUS = 292,
    DOT = 293,
    MULT = 294,
    EXP = 295,
    GT = 296,
    LT = 297,
    DOLLAR = 298
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 27 "parser.y" /* yacc.c:1909  */

    char * ystr;
    int   yint;
    float yfloat;

#line 104 "parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
