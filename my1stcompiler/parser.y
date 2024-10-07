%{
    #include <stdio.h>
    #include <string.h>
    extern int yylineno;
    extern char *yytext;
    void yyerror(const char *s);
%}
%union {
    int yint;
    float yfloat;
    char *ystr;
}
%start begin
%token LET COLON NUMBER_TYPE STRING_TYPE ASSIGN SEMICOLON 
%token IDENTIFIER CLASS_IDENTIFIER
%token <yint> NUMBER
%token <yfloat> FLOAT
%token <ystr> STRING
%token TRUE FALSE CONSOLE_LOG VAR CONST FLOAT_TYPE BOOLEAN_TYPE RETURN FUNCTION
%token LBRACKET RBRACKET LBRACE RBRACE LPARENTHESES RPARENTHESES COMMA
%token SINGLE_QUOTE ADD MINUS DOT DOUBLE_QUOTE MULT DIV EXP GT LT
%left '-' '+'
%left '*' '/'
%right '^'
%left '>' '<' '='

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
    | function_declaration
    | function_call
    | console_log
    | expression_statement
    | return_statement
;

variable_declaration:
    LET IDENTIFIER ASSIGN expression SEMICOLON
    | VAR IDENTIFIER ASSIGN expression SEMICOLON
    | CONST IDENTIFIER ASSIGN expression SEMICOLON
    | LET IDENTIFIER ASSIGN expression
    | VAR IDENTIFIER ASSIGN expression
    | CONST IDENTIFIER ASSIGN expression
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
;

expression:
    NUMBER
    | FLOAT
    | STRING
    | IDENTIFIER
    | array
    | expression ADD expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | LPARENTHESES expression RPARENTHESES
;

array:
    LBRACKET array_elements RBRACKET
;

array_elements:
    expression
    | expression COMMA array_elements
    | /* empty */
;

%%
int main(int argc, char *argv[])
{
    if (yyparse() == 0) {
        printf("codigo sem erros\n");
    }
    return 0;
}

void yyerror(const char *s) /* Called by yyparse on error */
{
    printf("Erro de sintaxe: %s na linha %d, token: %s\n", s, yylineno, yytext);
}