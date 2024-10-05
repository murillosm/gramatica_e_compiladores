%{
    #include <stdio.h>
    #include <ctype.h>
    #include "sym.h"
    #define AddVAR(n,t) SymTab=MakeVAR(n,t,SymTab)
    #define ASSERT(x,y) if(!(x)) printf("%s na  linha %d\n",(y),yylineno)
    #define CHECKIFVARISDECLARED(x) {\
                VAR * node=FindVAR(x);\
                if ( node == NULL )\
                   AddVAR(x,current_type);\
                else {\
                   printf("Variável %s já declarada na  linha %d\n",x,yylineno);\
                   semanticerror =1 ;\
                }\
               }

    #define UNDECL  0
    #define INT     1
    #define BOOL    2
    #define FLT     3
    int current_type=UNDECL;
    int semanticerror= 0;
    extern int yylineno;
    extern VAR *SymTab;
    FILE * output;
%}
%define parse.error verbose //aparecer mais detalhes dos erros
%union {
    char * ystr;
    int   yint;
    float yfloat;
}
%start begin
%token LET INTEGER IN  SKIP IF FI THEN ELSE END WHILE DO READ WRITE
%token ATRIB
%token <yint> NUMERO
%token <yfloat> REAL
%token <ystr> ID
%left '-' '+'
%left '*' '/'
%right '^'
%nonassoc '<' '>' '='
%type  <yint> exp

%%
begin : LET  declarations IN commands END
;

declarations : INTEGER { current_type=INT; fprintf(output,"int");} idlist ';' {fprintf(output,";");}  declarations
| REAL {current_type=FLT; fprintf(output,"float");}   idlist ';' {fprintf(output,";");}  declarations
| /*epslon*/  {current_type=UNDECL; }
;

idlist : ID  { fprintf(output,"%s",$1); CHECKIFVARISDECLARED ($1); }
| ID ',' {fprintf(output,"%s,",$1);} idlist  {CHECKIFVARISDECLARED ($1); }
;

commands : /* empty */
|  command ';' commands
;

command : SKIP
| READ ID
| WRITE exp
| ID ATRIB exp { VAR* node= FindVAR($1);
                 if (node==NULL)  printf ("Variável %s não declarada",$1);
                 else {
                    if ( node->type != $3 && !(node->type == INT && $3 == FLT)){
                           printf (" Tipo de %s não compátivel com a operação na linha %i \n",$1,yylineno);
                           semanticerror =1 ;
                         }
                 }
               }
| IF exp THEN commands FI
| WHILE exp DO commands END
;

exp : REAL { $$ = FLT;  }
| NUMERO  { $$ = INT;  }
| ID      {                 VAR* node= FindVAR($1);
                            int type ;
                            if (node==NULL)
                                 $$= UNDECL ;
                            else $$= node->type ;
                            }
| exp '<''=' exp
| exp '>''=' exp
| exp '<' exp
| exp '=' exp
| exp '>' exp
| exp '+' exp  {
                  $$ = INT;
                  if ($1==FLT || $3==FLT )
                        $$ = FLT;
                  if ($1==UNDECL || $3==UNDECL )
                        $$ = UNDECL;
      }
| exp '-' exp
| exp '*' exp
| exp '/' exp
| exp '^' exp
| '(' exp ')'  { $$ = $2; }
;


%%
main( int argc, char *argv[] )
{
  init_stringpool(10000);
  output = fopen("output.c","w");
 if ( yyparse () == 0 && semanticerror ==0) printf("codigo sem erros \n");
}

yyerror (char *s) /* Called by yyparse on error */
{
printf ("%s  na linha %d\n", s, yylineno );
}
