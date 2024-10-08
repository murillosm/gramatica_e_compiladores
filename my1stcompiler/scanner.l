%{
#include "parser.tab.h"
%}
%option yylineno

NUMBER [0-9]+
ID [a-zA-Z_][0-9a-zA-Z_]*
FLOAT [0-9]*\.[0-9]+
STRING_SINGLE_QUOTE \'[^\']*\'
STRING_DOUBLE_QUOTE \"[^\"]*\"
STRING_CRASIS_QUOTE \`[^`]*\`
TRUE true
FALSE false 

%%

{NUMBER}        { printf("Reconhecido: NUMBER (%s)\n", yytext); return(NUMBER); }
{STRING_SINGLE_QUOTE}   { printf("Reconhecido: STRING (%s)\n", yytext); return(STRING); }
{STRING_DOUBLE_QUOTE}   { printf("Reconhecido: STRING (%s)\n", yytext); return(STRING); }
{STRING_CRASIS_QUOTE}   { printf("Reconhecido: STRING (%s)\n", yytext); return(STRING); }
{FLOAT}         { printf("Reconhecido: FLOAT (%s)\n", yytext); return(FLOAT); }
{TRUE}          { printf("Reconhecido: TRUE\n"); return(TRUE); }
{FALSE}         { printf("Reconhecido: FALSE\n"); return(FALSE); }

"console.log"   { printf("Reconhecido: CONSOLE_LOG\n"); return (CONSOLE_LOG); }

let             { printf("Reconhecido: LET\n"); return(LET); }
var             { printf("Reconhecido: VAR\n"); return(VAR); }
const           { printf("Reconhecido: CONST\n"); return(CONST); }
number          { printf("Reconhecido: NUMBER_TYPE\n"); return(NUMBER_TYPE); }
string          { printf("Reconhecido: STRING_TYPE\n"); return(STRING_TYPE); }
float           { printf("Reconhecido: FLOAT_TYPE\n"); return(NUMBER_TYPE); }
boolean         { printf("Reconhecido: BOOLEAN_TYPE\n"); return(BOOLEAN_TYPE); }
return          { printf("Reconhecido: RETURN\n"); return(RETURN); }
function        { printf("Reconhecido: FUNCTION\n"); return(FUNCTION); }

"="             { printf("Reconhecido: ASSIGN\n"); return(ASSIGN); }
"=="            { printf("Reconhecido: EQ\n"); return(EQ); }
":"             { printf("Reconhecido: COLON\n"); return(COLON); }
";"             { printf("Reconhecido: SEMICOLON\n"); return(SEMICOLON); }
"["             { printf("Reconhecido: LBRACKET\n"); return (LBRACKET); }
"]"             { printf("Reconhecido: RBRACKET\n"); return (RBRACKET); }
"{"             { printf("Reconhecido: LBRACE\n"); return (LBRACE); }
"}"             { printf("Reconhecido: RBRACE\n"); return (RBRACE); }
"("             { printf("Reconhecido: LPARENTHESES\n"); return (LPARENTHESES); }
")"             { printf("Reconhecido: RPARENTHESES\n"); return (RPARENTHESES); }
","             { printf("Reconhecido: COMMA\n"); return (COMMA); }
"+"             { printf("Reconhecido: ADD\n"); return ADD; }
"-"             { printf("Reconhecido: MINUS\n"); return MINUS; }
"."             { printf("Reconhecido: DOT\n"); return DOT; }
"*"             { printf("Reconhecido: MULT\n"); return MULT; }
"/"             { printf("Reconhecido: DIV\n"); return DIV; }
"^"             { printf("Reconhecido: EXP\n"); return EXP; }
">"             { printf("Reconhecido: GT\n"); return GT; }
"<"             { printf("Reconhecido: LT\n"); return LT; }
"\""            { /* Ignorar aspas duplas isoladas */ }
"'"             { /* Ignorar aspas simples isoladas */ }
"`"             { /* Ignorar crase isolada */ }
"\$"            { printf("Reconhecido: DOLLAR\n"); return DOLLAR; }

{ID}       { printf("Reconhecido: IDENTIFIER (%s)\n", yytext); return(IDENTIFIER); }
"//".*     { /* Ignorar comentários de linha única */ }
"\n"                { /*incrementa sozinho lineno*/ }
[ \t]+              { /*ignorar espaços em branco*/ }
.          { return yytext[0]; }

%%