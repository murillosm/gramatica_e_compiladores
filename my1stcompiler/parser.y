%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    //#define AddVAR(n,t) SymTab=MakeVAR(n,t,SymTab)
    #define CHECKIFVARISDECLARED(x) {\
                VAR * node=FindVAR(x);\
                if ( node == NULL )\
                   AddVAR(x,current_type);\
                else {\
                   printf("Variável %s já declarada na  linha %d\n",x,yylineno);\
                   semanticerror =1 ;\
                }\
               }
    extern int yylineno;
    extern char *yytext;
    void yyerror(const char *s);
    int yylex(void);
    int semanticerror = 0;

    //extern VAR *SymTab;           
    FILE *output;

%}

%define parse.error verbose //aparecer mais detalhes dos erros
%union {
    char * ystr;
    int   yint;
    float yfloat;
}


%token <ystr> IDENTIFIER
%token <ystr> STRING
%token <yint> NUMBER
%token LET VAR CONST ASSIGN SEMICOLON DOUBLE_QUOTE SINGLE_QUOTE CRASIS_QUOTE
%token LPAREN RPAREN
%token CONSOLE_LOG
%token FLOAT TRUE FALSE BOOLEAN ANY_TYPE
%token NUMBER_TYPE STRING_TYPE BOOLEAN_TYPE RETURN FUNCTION ERROR_LITERAL
%token EQ COLON LBRACKET RBRACKET LBRACE RBRACE LPARENTHESES RPARENTHESES COMMA MINUS DOT MULT EXP GT LT DOLLAR
%left '-' '+'
%left '*' '/'
%right '^'

%type <ystr> expression

%%

program:
    statements
;

statements:
    statement statements
    | /* empty */
;

 statement:
    variable_declaration_expression { fprintf(output, ";"); }
    | variable_declaration_expression SEMICOLON { fprintf(output, ";"); }
    | console_log
    | expression_statement
;   

expression_statement:
    expression SEMICOLON {
        fprintf(output, "%s", $1);
    }
    | expression {
        fprintf(output, "%s", $1);
    }
;

variable_declaration_expression:
    variable_declaration expression {
        fprintf(output, "%s", $2);
    }
;

variable_declaration:
    LET IDENTIFIER ASSIGN {
        fprintf(output, "let %s: number = ", $2);
    }
    | VAR IDENTIFIER ASSIGN{
        fprintf(output, "var %s: number = ", $2);
    }
    | CONST IDENTIFIER ASSIGN{
        fprintf(output, "const %s: number = ", $2);
    }
;

console_log:
    CONSOLE_LOG LPAREN expression RPAREN { fprintf(output, "console.log(%s)", $3); }
;

expression:
    NUMBER { $$ = strdup(yytext); }
    | IDENTIFIER { $$ = strdup(yytext); }
    | STRING { $$ = strdup(yytext); }
    | expression '+' expression { 
                                    char *result = malloc(strlen($1) + strlen($3) + 4);
                                    sprintf(result, "%s + %s", $1, $3);
                                    $$ = result;
                                }
    | expression '-' expression { 
                                    char *result = malloc(strlen($1) + strlen($3) + 4);
                                    sprintf(result, "%s - %s", $1, $3);
                                    $$ = result;
                                }
    | expression '*' expression { 
                                    char *result = malloc(strlen($1) + strlen($3) + 4);
                                    sprintf(result, "%s * %s", $1, $3);
                                    $$ = result;
                                }
    | expression '/' expression { 
                                    char *result = malloc(strlen($1) + strlen($3) + 4);
                                    sprintf(result, "%s / %s", $1, $3);
                                    $$ = result;
                                }
;

%%

int main(int argc, char *argv[]) {
    output = fopen("output.ts", "w");
    if (!output) {
        fprintf(stderr, "Erro ao abrir o arquivo de saída.\n");
        return 1;
    }
    if (yyparse() == 0 && semanticerror == 0) {
        printf("Código sem erros\n");
    }
    fclose(output);
    return 0;
}

void yyerror(const char *s) {
    printf("%s na linha %d\n", s, yylineno);
}