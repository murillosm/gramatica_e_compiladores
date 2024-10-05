%{
#include "parser.tab.h"
char *stringpool(char *);
extern FILE * output;
%}
%option yylineno
DIGIT [0-9]
ID [a-z][0-9a-z]*

%%
{DIGIT}*"."{DIGIT}+ { yylval.yfloat = atof(yytext); return(REAL);}
{DIGIT}+ { yylval.yint = atoi(yytext); return(NUMERO);}
":="     { return(ATRIB); }
integer {  return(INTEGER); }
real    { return(REAL);}
if      { return(IF);}
fi      { return(FI);}
then    { return(THEN);}
end     { return(END);}
skip    { return(SKIP);}
let     { return(LET);}
in      { return(IN);}
do      { return(DO);}
while   { return(WHILE);}
read    { return(READ);}
write   { return(WRITE);}
{ID}    { yylval.ystr = stringpool(yytext) ;  return(ID); }
"\\\\"[ a-z]*\n
"\n"     { fprintf(output,"\n"); /*incrementa sozinho lineno*/ }
[ \t]+  { fprintf(output,"%s",yytext); }
.       { return(yytext[0]);}
%%