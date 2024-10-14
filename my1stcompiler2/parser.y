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
%token LET COLON NUMBER_TYPE STRING_TYPE ASSIGN SEMICOLON BOOLEAN_TYPE CLASS_IDENTIFIER IF ELSE MAP
%token <ystr> IDENTIFIER 
%token <yint> NUMBER
%token <yfloat> FLOAT
%token <ystr> STRING
%token TRUE FALSE CONSOLE_LOG CONST RETURN FUNCTION BOOLEAN ERROR
%token LBRACKET RBRACKET LBRACE RBRACE LPARENTHESES RPARENTHESES COMMA
%token SINGLE_QUOTE DOT DOUBLE_QUOTE EXP
%token EQ BACKTICK DOLLAR ARROW
%token ASYNC AWAIT
%left '-' '+'
%left '*' '/'
%right '^'
%left '>' '<' '='

%type <ystr> expressions parameter_list argument_list function_call array array_elements array_manipulate async_function console_arguments wait_expression statement statements

%%
begin : 
    statements
;

statements:
    statement statements { asprintf(&$$, "%s\n%s", $1, $2); }
    | /* empty */ { $$ = strdup(""); }
;

statement:
    variable_declaration { $$ = strdup(""); }
    | variable_declaration SEMICOLON { $$ = strdup(""); }
    | function_declaration { $$ = strdup(""); }
    | async_function { $$ = strdup(""); }
    | console_log { $$ = strdup(""); }
    | expression_statement { $$ = strdup(""); }
    | return_statement { $$ = strdup(""); }
    | if_statement { $$ = strdup(""); }
    | function_call { $$ = strdup(""); }
;

variable_declaration:
    LET IDENTIFIER ASSIGN expressions { fprintf(output, "%s := ", $2); fprintf(output, "%s", $4); }
    | CONST IDENTIFIER ASSIGN expressions { fprintf(output, "const %s = ", $2); fprintf(output, "%s", $4); }
;

function_declaration:
    FUNCTION IDENTIFIER LPARENTHESES parameter_list RPARENTHESES LBRACE statements RBRACE
;


parameter_list:
    IDENTIFIER {
        asprintf(&$$, "%s string", $1); 
    }
    | IDENTIFIER COMMA parameter_list {
        asprintf(&$$, "%s string, %s", $1, $3);
    }
    | /* empty */ {
        $$ = strdup("");  
    }
;

function_call:
    expressions LPARENTHESES argument_list RPARENTHESES { fprintf(output, "%s(%s)", $1, $3); }
;

argument_list:
    expressions
    | expressions COMMA argument_list
    | /* empty */ { $$ = strdup(""); }
;

console_log:
    CONSOLE_LOG LPARENTHESES console_arguments RPARENTHESES SEMICOLON { fprintf(output, "fmt.Println(%s)\n", $3); }
;



console_arguments:
    expressions { $$ = strdup($1); }
    | expressions COMMA console_arguments { asprintf(&$$, "%s, %s", $1, $3); }

;

expression_statement:
    expressions SEMICOLON
;

return_statement:
    RETURN expressions SEMICOLON { fprintf(output, "return %s\n", $2); }
    | RETURN expressions
;


if_statement:
    IF LPARENTHESES expressions RPARENTHESES LBRACE { fprintf(output, "if %s {", $3); } statements RBRACE { fprintf(output, "}\n"); } else_declaration
;

else_declaration:
    ELSE LBRACE { fprintf(output, "else {\n\t"); } statements RBRACE { fprintf(output, "\n}\n"); }
    | /* empty */
;

expressions:
    NUMBER { $$ = strdup(yytext); }
    | FLOAT { $$ = strdup(yytext); }
    | STRING { $$ = remove_quotes(yytext); }
    | BOOLEAN { $$ = strdup(yytext); }
    | IDENTIFIER { $$ = strdup(yytext); }
    | array { $$ = strdup($1); }
    | array_manipulate
    | expressions '+' expressions { asprintf(&$$, "%s + %s", $1, $3); }
    | expressions '-' expressions { asprintf(&$$, "%s - %s", $1, $3); }
    | expressions '*' expressions { asprintf(&$$, "%s * %s", $1, $3); }
    | expressions '/' expressions { asprintf(&$$, "%s / %s", $1, $3); }
    | expressions '^' expressions { asprintf(&$$, "%s ^ %s", $1, $3); }
    | expressions EQ expressions { asprintf(&$$, "%s == %s", $1, $3); }
    | expressions ASSIGN expressions { asprintf(&$$, "%s = %s", $1, $3); }
    | expressions '>' expressions { asprintf(&$$, "%s > %s", $1, $3); }
    | expressions '<' expressions { asprintf(&$$, "%s < %s", $1, $3); }
    | RBRACKET expressions LBRACKET { asprintf(&$$, "[%s]", $2); }
    | LPARENTHESES expressions RPARENTHESES { asprintf(&$$, "(%s)", $2); }
    | LPARENTHESES array_elements RPARENTHESES ARROW expressions { asprintf(&$$, "func(%s) {\n\treturn %s\n}", $2, $5); }
    | LPARENTHESES RPARENTHESES ARROW expressions { asprintf(&$$, "func() {\n\treturn %s\n}", $4); }
    | LPARENTHESES array_elements RPARENTHESES { fprintf(output, "(%s)", $2); } 
    | wait_expression
;

wait_expression:
    AWAIT IDENTIFIER expressions { asprintf(&$$, "await %s %s", $2, $3); }
    | AWAIT IDENTIFIER DOT IDENTIFIER { asprintf(&$$, "await %s.%s", $2, $4); }
;

array_manipulate:
	expressions DOT MAP LPARENTHESES IDENTIFIER ARROW expressions RPARENTHESES { 
		asprintf(&$$, "make([]any, len(%s))\nfor i, %s := range %s {\n\tdoubled[i] = %s\n}", $1, $5, $1, $7); 
	}
;

async_function:
    ASYNC FUNCTION IDENTIFIER LPARENTHESES parameter_list RPARENTHESES LBRACE statements RBRACE {
        fprintf(output, "func %s(%s string) (data map[any]interface{}, err error) {", $3, $5);
        fprintf(output, "}");
    }
;



/* async_function_call:
    ASYNC FUNCTION IDENTIFIER LPARENTHESES argument_list RPARENTHESES{
        fprintf(output, "%s(%s)", $3, $5);
    }
; */

/* interpolated_expression:
    interpolated_part { $$ = strdup($1); }
    | interpolated_expression interpolated_part { asprintf(&$$, "%s%s", $1, $2); }
;

interpolated_part:
    STRING { $$ = strdup($1); }
    | DOLLAR LBRACE expressions RBRACE { asprintf(&$$, "${%s}", $3); }
; */

array:
    LBRACKET array_elements RBRACKET { asprintf(&$$, "[]any{%s}", $2); }
;

array_elements:
    expressions { $$ = strdup($1); }
    | expressions COMMA array_elements { asprintf(&$$, "%s, %s", $1, $3); }
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