%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include <stdbool.h>
    #include "sym.h"
    #define ASSERT(x,y) if(!(x)) printf("%s na  linha %d\n",(y),yylineno)
    extern int yylineno;
    FILE * output;

    char identifierDefined[100];

    char* remove_quotes(const char* str) {
        int len = strlen(str);
        char* result = (char*)malloc(len + 1);
        int i, j = 0;

        for (i = 0; i < len; i++) {  
            if (str[i] != '\"') {
                result[j++] = str[i];
            }
        }

        result[j] = '\0';
        return result;
    }
%}

%define parse.error verbose //aparecer mais detalhes dos erros
%union {
    int yint;
    float yfloat;
    char *ystr;
}
%start program
%token LET COLON NUMBER_TYPE STRING_TYPE ASSIGN SEMICOLON BOOLEAN_TYPE
%token CLASS_IDENTIFIER
%token <yint> NUMBER
%token <yfloat> FLOAT
%token <ystr> STRING IDENTIFIER
%token TRUE FALSE CONSOLE_LOG VAR CONST RETURN FUNCTION
%token LBRACKET RBRACKET LBRACE RBRACE LPARENTHESES RPARENTHESES COMMA
%token SINGLE_QUOTE ADD MINUS DOT DOUBLE_QUOTE MULT DIV EXP GT LT
%token EQ BACKTICK DOLLAR
%token REAL NUMERO BOOLEAN ERROR_LITERAL ANY_TYPE SUB MUL LPAREN RPAREN CRASIS_QUOTE
%left '-' '+'
%left '*' '/'
%right '^'
%left '>' '<' '='

%type <ystr> expression

%%

program:
    declarations
    ;

declarations:
    declaration
    | declarations declaration
    ;

declaration:
    variavel_declaration SEMICOLON
    | variavel_declaration '\n'
    ;

variavel_declaration:
    LET IDENTIFIER ASSIGN expression {
        fprintf(output, "%s := ", $2);
    } expression
    ;

expression:
    NUMBER { fprintf(output, "%d", $1); }
    | FLOAT { fprintf(output, "%f", $1); }
    | IDENTIFIER { fprintf(output, "%s", $1); }
    ;

%%
main( int argc, char *argv[] )
{
    init_stringpool(10000);
    output = fopen("output.go","w");
    if ( yyparse () == 0) printf("codigo sem erros \n");
}

yyerror (char *s) /* Called by yyparse on error */
{
    printf ("%s  na linha %d\n", s, yylineno );
}