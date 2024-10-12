%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #define CHECKIFVARISDECLARED(x) {\
                VAR * node=FindVAR(x);\
                if ( node == NULL )\
                   AddVAR(x,current_type);\
                else {\
                   printf("Variável %s já declarada na linha %d\n",x,yylineno);\
                   semanticerror =1 ;\
                }\
               }
    extern int yylineno;
    extern char *yytext;
    void yyerror(const char *s);
    int yylex(void);
    int semanticerror = 0;

    FILE *output;

    int is_number(const char* value);
    int is_string(const char* value);
%}

%define parse.error verbose
%union {
    char * ystr;
    int   yint;
    float yfloat;
}

%token <ystr> IDENTIFIER
%token <ystr> STRING
%token <yint> NUMBER
%token LET VAR CONST ASSIGN SEMICOLON
%token LPAREN RPAREN
%token CONSOLE_LOG
%token FLOAT
%token BOOLEAN ERROR_LITERAL NUMBER_TYPE STRING_TYPE BOOLEAN_TYPE ANY_TYPE RETURN FUNCTION
%token EQ COLON LBRACKET RBRACKET LBRACE RBRACE COMMA DOT EXP GT LT DOUBLE_QUOTE SINGLE_QUOTE CRASIS_QUOTE DOLLAR
%token ADD SUB MUL DIV

%type <ystr> expression
%type <ystr> variable_declaration

%%

program:
    statements
;

statements:
    statement statements
    | /* empty */
;

statement:
    variable_declaration SEMICOLON { fprintf(output, ";"); }
    | console_log SEMICOLON { fprintf(output, ";"); }
    | expression_statement
;   

expression_statement:
    expression SEMICOLON {
        fprintf(output, "%s;", $1);
    }
    | expression {
        fprintf(output, "%s", $1);
    }
;

variable_declaration:
    LET IDENTIFIER ASSIGN expression {
        if (is_number($4)) {
            fprintf(output, "let %s: number = %s", $2, $4);
        } else if (is_string($4)) {
            fprintf(output, "let %s: string = %s", $2, $4);
        }
    }
    | VAR IDENTIFIER ASSIGN expression {
        if (is_number($4)) {
            fprintf(output, "var %s: number = %s", $2, $4);
        } else if (is_string($4)) {
            fprintf(output, "var %s: string = %s", $2, $4);
        }
    }
    | CONST IDENTIFIER ASSIGN expression {
        if (is_number($4)) {
            fprintf(output, "const %s: number = %s", $2, $4);
        } else if (is_string($4)) {
            fprintf(output, "const %s: string = %s", $2, $4);
        }
    }
;

console_log:
    CONSOLE_LOG LPAREN expression RPAREN { fprintf(output, "console.log(%s)", $3); }
;

expression:
    NUMBER { $$ = strdup(yytext); }
    | IDENTIFIER {
        // Aqui, verifica se o identificador é do tipo number
        if (is_number($1)) {
            $$ = strdup(yytext);
        } else {
            printf("Erro semântico: %s não é do tipo number.\n", $1);
            semanticerror = 1;
        }
    }
    | STRING { $$ = strdup(yytext); }
    | expression ADD expression {
        if (is_number($1) && is_number($3)) {
            $$ = (char*) malloc(strlen($1) + strlen($3) + 4);
            sprintf($$, "%s + %s", $1, $3);
        } else {
            printf("Erro semântico: operação aritmética não permitida entre tipos incompatíveis.\n");
            semanticerror = 1;
        }
    }
    | expression SUB expression {
        if (is_number($1) && is_number($3)) {
            $$ = (char*) malloc(strlen($1) + strlen($3) + 4);
            sprintf($$, "%s - %s", $1, $3);
        } else {
            printf("Erro semântico: operação aritmética não permitida entre tipos incompatíveis.\n");
            semanticerror = 1;
        }
    }
    | expression MUL expression {
        if (is_number($1) && is_number($3)) {
            $$ = (char*) malloc(strlen($1) + strlen($3) + 4);
            sprintf($$, "%s * %s", $1, $3);
        } else {
            printf("Erro semântico: operação aritmética não permitida entre tipos incompatíveis.\n");
            semanticerror = 1;
        }
    }
    | expression DIV expression {
        if (is_number($1) && is_number($3)) {
            $$ = (char*) malloc(strlen($1) + strlen($3) + 4);
            sprintf($$, "%s / %s", $1, $3);
        } else {
            printf("Erro semântico: operação aritmética não permitida entre tipos incompatíveis.\n");
            semanticerror = 1;
        }
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

int is_number(const char* value) {
    int i = 0;
    int has_dot = 0;
    
    // Verifica cada caractere
    for (i = 0; i < strlen(value); i++) {
        if (!isdigit(value[i])) {
            if (value[i] == '.' && !has_dot) {
                has_dot = 1; // Permite apenas um ponto decimal
            } else {
                return 0; // Não é um número
            }
        }
    }
    return 1; // É um número
}

int is_string(const char* value) {
    // Verifica se começa e termina com aspas simples, duplas ou crase
    if ((value[0] == '"' && value[strlen(value)-1] == '"') ||
        (value[0] == '\'' && value[strlen(value)-1] == '\'') ||
        (value[0] == '`' && value[strlen(value)-1] == '`')) {
        return 1;
    }
    return 0;
}
