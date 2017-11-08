%{
#include <stdio.h>
extern FILE *yyin;
int yylex(void);
int yyerror(char*);
%}
%union{
    int itype;
    float dtype;
    char *str;
}

%token OR_OP
%token AND_OP

%token TRUE
%token FALSE

%token LET

%token FOR
%token WHILE
%token IF
%token ELSE

%token <itype> INTEGER
%token <dtype> FLOAT
%token <str> IDENT

%left '+' '-' OU
%left '*' '/' ET

%%

declarator
        :   IDENT
        ;

init_declarator
        :   declarator
        |   declarator '=' initializer
        ;

init_declarator_list
        :   init_declarator
        |   init_declarator_list ',' init_declarator
        ;

declaration
        :   LET init_declarator_list ';'
        ;

initializer
        :
        ;

declaration_list
        :   declaration
        |   declaration_list declaration
        ;

locical_or_exp
        :   logical_and_exp
        |   logical_or_exp OR_OP logical_and_exp
        ;

logical_and_exp
        :   

iteration_statement
        :   WHILE '(' expression ')' statement
        |   FOR '(' expression_statement expression_statement expression ')'
statement
        ;

selection_statement
        :   IF '(' expression ')' statement
        |   IF '(' expression ')' statement ELSE statement

expression_statement
        :   ';'
        |   expression ';'
        ;

compound_statement
        :   '{' statement_list '}'
        |   '{' declaration_list '}'
        |   '{' declaration_list statement_list '}'
        ;

statement_list
        :   statement
        |   statement_list statement
        ;

statement
        :   expression_statement
        |   selection_statement
        |   iteration_statement
        |   compound_statement
        ; 
%%


int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    if (yyparse() == 0) {
        printf("success parsing");
        return 0;
    }
    return 1;
}

int yyerror(char *s)
{
    printf("%s\n", s);
    return 1;
}
