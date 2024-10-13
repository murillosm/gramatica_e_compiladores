%{
    #include <stdio.h>
    #include <string.h>
    extern int yylineno;
    extern char *yytext;
    #include <stdlib.h>
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
            if (str[i] == '\'') {
                result[j++] = '\"';
            } else if (str[i] != '\"') {
                result[j++] = str[i];
            } else{
                result[j++] = '\"';
            }
        }

        result[j] = '\0';
        return result;
    }
%}
%union {
    int yint;
    float yfloat;
    char *ystr;
}
%start begin
%token LET COLON NUMBER_TYPE STRING_TYPE ASSIGN SEMICOLON BOOLEAN_TYPE CLASS_IDENTIFIER
%token <ystr> IDENTIFIER 
%token <yint> NUMBER
%token <yfloat> FLOAT
%token <ystr> STRING
%token TRUE FALSE CONSOLE_LOG CONST RETURN FUNCTION BOOLEAN ERROR
%token LBRACKET RBRACKET LBRACE RBRACE LPARENTHESES RPARENTHESES COMMA
%token SINGLE_QUOTE DOT DOUBLE_QUOTE EXP GT LT
%token EQ BACKTICK DOLLAR
%left '-' '+'
%left '*' '/'
%right '^'
%left '>' '<' '='

%type <ystr> expression

%%
begin : 
    statements
;

statements:
    statement statements
    | /* empty */
;

statement:
    variable_declaration
    | variable_declaration SEMICOLON
    | function_declaration
    | function_call
    | console_log
    | expression_statement
    | return_statement
;

variable_declaration:
    LET IDENTIFIER ASSIGN expression { fprintf(output, "%s := ", $2); fprintf(output, "%s", $4); }
    | CONST IDENTIFIER ASSIGN expression { fprintf(output, "const %s = ", $2); fprintf(output, "%s", $4); }
;

function_declaration:
    FUNCTION IDENTIFIER LPARENTHESES parameter_list RPARENTHESES LBRACE statements RBRACE
;

parameter_list:
    IDENTIFIER
    | IDENTIFIER COMMA parameter_list
    | /* empty */
;

function_call:
    IDENTIFIER LPARENTHESES argument_list RPARENTHESES SEMICOLON
    | IDENTIFIER LPARENTHESES argument_list RPARENTHESES
;

argument_list:
    expression
    | expression COMMA argument_list
    | /* empty */
;

console_log:
    CONSOLE_LOG LPARENTHESES expression RPARENTHESES SEMICOLON
;

expression_statement:
    expression SEMICOLON
;

return_statement:
    RETURN expression SEMICOLON
    | RETURN expression
;

expression:
    NUMBER { $$ = strdup(yytext); }
    | FLOAT { $$ = strdup(yytext); }
    | STRING { $$ = remove_quotes(yytext); }
    | BOOLEAN { $$ = strdup(yytext); }
    | IDENTIFIER { $$ = strdup(yytext); }
    | expression '+' expression { asprintf(&$$, "%s + %s", $1, $3); }
    | expression '-' expression { asprintf(&$$, "%s - %s", $1, $3); }
    | expression '*' expression { asprintf(&$$, "%s * %s", $1, $3); }
    | expression '/' expression { asprintf(&$$, "%s / %s", $1, $3); }
;    

interpolated_expression:
    interpolated_part
    | interpolated_expression interpolated_part
;

interpolated_part:
    STRING
    | DOLLAR LBRACE expression RBRACE
;

array:
    LBRACKET array_elements RBRACKET
;

array_elements:
    expression
    | expression COMMA array_elements
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