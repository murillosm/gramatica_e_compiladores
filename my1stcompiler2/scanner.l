%{
#include "parser.tab.h"
char *stringpool(char *);
extern FILE * output;
%}
%option yylineno

NUMBER [0-9]*
FLOAT [0-9]*"."[0-9]+
ID [a-z][0-9a-zA-Z]*
/* CLASS_ID [A-Z][0-9a-zA-Z]* */
STRING_SINGLE_QUOTE \'[^\']*\'
STRING_DOUBLE_QUOTE \"[^"]*\"
STRING_CRASIS_QUOTE \`[^`]*\`
TRUE true
FALSE false
ERROR [A-Z][a-zA-Z]*

%%

{NUMBER}            { printf("Reconhecido: NUMBER (%s)\n", yytext); yylval.yint = atoi(yytext); return(NUMBER);}
{FLOAT}             { printf("Reconhecido: FLOAT (%s)\n", yytext); yylval.yfloat = atof(yytext); return (FLOAT);}
{TRUE}              { printf("Reconhecido: TRUE (%s)\n", yytext); yylval.ystr = stringpool(yytext); return (BOOLEAN);}
{FALSE}             { printf("Reconhecido: FALSE (%s)\n", yytext); yylval.ystr = stringpool(yytext); return (BOOLEAN);}
{STRING_SINGLE_QUOTE}    { printf("Reconhecido: STRING (%s)\n", yytext); yylval.ystr = stringpool(yytext); return (STRING);}
{STRING_DOUBLE_QUOTE}    { printf("Reconhecido: STRING (%s)\n", yytext); yylval.ystr = stringpool(yytext); return (STRING);}
{STRING_CRASIS_QUOTE}         { printf("Reconhecido: STRING (%s)\n", yytext); yylval.ystr = stringpool(yytext); return (STRING);}
{ERROR}               { printf("Reconhecido: ERROR (%s)\n", yytext); yylval.ystr = stringpool(yytext); return (ERROR);}
"console.log"   { printf("Reconhecido: CONSOLE_LOG\n"); return (CONSOLE_LOG); }

let             { printf("Reconhecido: LET\n"); return(LET); }
const           { printf("Reconhecido: CONST\n"); return(CONST); }
number          { printf("Reconhecido: NUMBER_TYPE\n"); return(NUMBER_TYPE); }
string          { printf("Reconhecido: STRING_TYPE\n"); return(STRING_TYPE); }
float           { printf("Reconhecido: FLOAT_TYPE\n"); return(NUMBER_TYPE); }
boolean         { printf("Reconhecido: BOOLEAN_TYPE\n"); return(BOOLEAN_TYPE); }
return          { printf("Reconhecido: RETURN\n"); return(RETURN); }
function        { printf("Reconhecido: FUNCTION\n"); return(FUNCTION); }
if              { printf("Reconhecido: IF\n"); return(IF); }
else            { printf("Reconhecido: ELSE\n"); return(ELSE); }
"=>"           { printf("Reconhecido: ARROW\n"); return(ARROW); }

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
"."             { printf("Reconhecido: DOT\n"); return DOT; }

"^"             { printf("Reconhecido: EXP\n"); return EXP; }
"\""            { printf("Reconhecido: DOUBLE_QUOTE\n"); return DOUBLE_QUOTE; }
"'"             { printf("Reconhecido: SINGLE_QUOTE\n"); return SINGLE_QUOTE; }
"`"             { printf("Reconhecido: BACKTICK\n"); return BACKTICK; }
"\$"            { printf("Reconhecido: DOLLAR\n"); return DOLLAR; }

{ID}            { printf("Reconhecido: IDENTIFIER (%s)\n", yytext); yylval.ystr = stringpool(yytext); return(IDENTIFIER);}
"\\"[ a-z]*\n 
"\n"                { fprintf(output,"\n"); /*incrementa sozinho lineno*/ }
[ \t]+              
.          { return yytext[0]; }

%%