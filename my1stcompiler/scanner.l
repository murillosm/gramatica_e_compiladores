%{
#include "parser.tab.h"
%}
%option yylineno
NUMBER [0-9]*
ID [a-z][0-9a-zA-Z]*
FLOAT [0-9]*\.[0-9]+
CLASS_ID [A-Z][0-9a-z]*
STRING_SINGLE_QUOTE \'[^\']*\'
STRING_DOUBLE_QUOTE \"[^\"]*\"
STRING_GRASIS_QUOTE \`[^\`]*\`
TRUE true
FALSE false 


%%
{NUMBER}        { printf("Reconhecido: NUMBER (%s)\n", yytext); return(NUMBER);}
{STRING_SINGLE_QUOTE}   { printf("Reconhecido: STRING (%s)\n", yytext); return(STRING);}
{STRING_DOUBLE_QUOTE}   { printf("Reconhecido: STRING (%s)\n", yytext); return(STRING);}
{FLOAT}         { printf("Reconhecido: FLOAT (%s)\n", yytext); return(FLOAT);}
{STRING_GRASIS_QUOTE}   { printf("Reconhecido: STRING (%s)\n", yytext); return(STRING);}
{TRUE}          { printf("Reconhecido: TRUE (%s)\n", yytext); return(TRUE);}
{FALSE}         { printf("Reconhecido: FALSE (%s)\n", yytext); return(FALSE);}

"console.log"   { printf("Reconhecido: CONSOLE_LOG\n"); return (CONSOLE_LOG); }
"="             { printf("Reconhecido: ASSIGN\n"); return(ASSIGN);}
let             { printf("Reconhecido: LET\n"); return(LET);}
var             { printf("Reconhecido: VAR\n"); return(VAR);}
const           { printf("Reconhecido: CONST\n"); return(CONST);}
number          { printf("Reconhecido: NUMBER_TYPE\n"); return(NUMBER_TYPE);}
string          { printf("Reconhecido: STRING_TYPE\n"); return(STRING_TYPE);}
float           { printf("Reconhecido: FLOAT_TYPE\n"); return(FLOAT_TYPE);}
boolean         { printf("Reconhecido: BOOLEAN_TYPE\n"); return(BOOLEAN_TYPE);}
return          { printf("Reconhecido: RETURN\n"); return(RETURN);}
function        { printf("Reconhecido: FUNCTION\n"); return(FUNCTION);}

":"             { printf("Reconhecido: COLON\n"); return(COLON);}
";"             { printf("Reconhecido: SEMICOLON\n"); return(SEMICOLON);}
"["             { printf("Reconhecido: LBRACKET\n"); return (LBRACKET); }
"]"             { printf("Reconhecido: RBRACKET\n"); return (RBRACKET); }
"{"             { printf("Reconhecido: LBRACE\n"); return (LBRACE); }
"}"             { printf("Reconhecido: RBRACE\n"); return (RBRACE); }
"("             { printf("Reconhecido: LPARENTHESES\n"); return (LPARENTHESES); }
")"             { printf("Reconhecido: RPARENTHESES\n"); return (RPARENTHESES); }
","             { printf("Reconhecido: COMMA\n"); return (COMMA); }
"'"             { printf("Reconhecido: SINGLE_QUOTE\n"); return SINGLE_QUOTE; }
"+"             { printf("Reconhecido: ADD\n"); return ADD; }
"-"             { printf("Reconhecido: MINUS\n"); return MINUS; }
"."             { printf("Reconhecido: DOT\n"); return DOT; }
"*"             { printf("Reconhecido: MULT\n"); return MULT; }
"/"             { printf("Reconhecido: DIV\n"); return DIV; }
"^"             { printf("Reconhecido: EXP\n"); return EXP; }
">"             { printf("Reconhecido: GT\n"); return GT; }
"<"             { printf("Reconhecido: LT\n"); return LT; }
"\""            { printf("Reconhecido: DOUBLE_QUOTE\n"); return DOUBLE_QUOTE; }

{ID}       { printf("Reconhecido: IDENTIFIER (%s)\n", yytext); return(IDENTIFIER);}
{CLASS_ID} { printf("Reconhecido: CLASS_IDENTIFIER (%s)\n", yytext); return(CLASS_IDENTIFIER);}
"\\\\"[ a-z]*\n
"\n"     {  /*incrementa sozinho lineno*/ }
[ \t]+
.       { return(yytext[0]);}
%%