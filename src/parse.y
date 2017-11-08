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
%token LE_OP
%token GE_OP
%token EQ_OP
%token NE_OP

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
        :   assignement_expression
        ;

assignement_expression
        :   logical_or_expression
        ;

declaration_list
        :   declaration
        |   declaration_list declaration
        ;

logical_or_expression
        :   logical_and_expression
        |   logical_or_expression OR_OP logical_and_expression
        ;

logical_and_expression
        :   equality_expression
        |   logical_and_expression AND_OP logical
        |   logical
        ;

logical
        :   TRUE
        |   FALSE
        ;

equality_expression
        :   relational_expression
        |   equality_expression EQ_OP relational_expression
        |   equality_expression NE_OP relational_expression
        ;

relational_expression
        :   sum_expression
        |   relational_expression LE_OP sum_expression
        |   relational_expression GE_OP sum_expression
        |   relational_expression '<' sum_expression
        |   relational_expression '>' sum_expression
        ;

sum_expression
        :   sum_expression '+' product_expression
        |   sum_expression '-' product_expression
        |   product_expression
        ;  

product_expression
        :   product_expression '*' cast_expression
        |   product_expression '/' cast_expression
        |   product_expression '%' cast_expression
        |   cast_expression
        ;

cast_expression
        :   IDENT
        |   '(' expression ')'
        ;

iteration_statement
        :   WHILE '(' expression ')' statement
        |   FOR '(' expression_statement expression_statement expression ')'
statement
        ;

selection_statement
        :   IF '(' expression ')' statement
        |   IF '(' expression ')' statement ELSE statement

expression
        :   assignement_expression
        |   expression ',' assignement_expression
        ;

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
