%{
#include "parser.tab.h"
char *stringpool(char *);
extern FILE * output;
%}
%option yylineno

NUMBER [0-9]+
ID [a-zA-Z_][0-9a-zA-Z_]*
FLOAT [0-9]*\.[0-9]+
STRING_SINGLE_QUOTE  \'[^\']*\'
STRING_DOUBLE_QUOTE  \"[^\"]*\'
STRING_CRASIS_QUOTE  \`[^`]*\`

TRUE true
FALSE false 

%%
{NUMBER}        { yylval.yint = atoi(yytext); return NUMBER; }
{STRING_SINGLE_QUOTE} { yylval.ystr = strdup(yytext); return STRING; }
{STRING_DOUBLE_QUOTE} { yylval.ystr = strdup(yytext); return STRING; }
{STRING_CRASIS_QUOTE} { yylval.ystr = strdup(yytext); return STRING; }
{FLOAT}         {yylval.yfloat = atof(yytext); return (FLOAT);}
{TRUE}          {yylval.ystr = strdup(yytext); return (BOOLEAN);}
{FALSE}         {yylval.ystr = strdup(yytext); return (BOOLEAN);}

"console.log"   {return (CONSOLE_LOG); }

let             {return(LET); }
var             {return(VAR); }
const           {return(CONST); }
number          {return(NUMBER_TYPE); }
string          {return(STRING_TYPE); }
float           {return(NUMBER_TYPE); }
boolean         {return(BOOLEAN_TYPE); }
any             {return(ANY_TYPE); }
return          {return(RETURN); }
function        {return(FUNCTION); }

"="             {return(ASSIGN); }
"=="            {return(EQ); }
":"             {return(COLON); }
";"             {return(SEMICOLON); }
"["             {return (LBRACKET); }
"]"             {return (RBRACKET); }
"{"             {return (LBRACE); }
"}"             {return (RBRACE); }
"("             {return (LPAREN); }
")"             {return (RPAREN); }
","             {return (COMMA); }
"."             {return DOT; }
"^"             {return EXP; }
">"             {return GT; }
"<"             {return LT; }
"\""            {return DOUBLE_QUOTE; }
"'"             {return SINGLE_QUOTE; }
"`"             {return CRASIS_QUOTE; }
"\$"            {return DOLLAR; }
[\n]+           { /* Ignorar quebras de linha */ }
[\t ]+          { /* Ignorar espaços em branco */ }
{ID}            { yylval.ystr = stringpool(yytext); return IDENTIFIER; }
"//".*          { /* Ignorar comentários de linha única */ }
.          { return yytext[0]; }

%%