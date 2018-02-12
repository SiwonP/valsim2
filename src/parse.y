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

%left '+' '-' OR_OP
%left '*' '/' AND_OP

%%
statement_list
: statement
| statement_list statement
;

statement
: expression_statement
| if_statement
| compound_statement
;

if_statement
: IF '(' expression ')' statement
| IF '(' expression ')' ELSE statement
;

compound_statement
: '{' '}'
| '{' statement_list '}'
| '{' declarator_list '}'
| '{' declarator_list statement_list '}'
;

declarator_list
: declarator ';'
| declarator_list ',' declarator ';'
;

declarator
: LET IDENT 
| LET IDENT '=' expression
| IDENT '=' expression
;

variables
: variable
| variable ',' variables

variable
: IDENT
| IDENT = expression
;

assignement_expression
: expression
| IDENT '=' assignement_expression
;

expression_statement
: expression ';'
| ';'
;

expression
: logical_or_expression
| additive_expression
;

logical_or_expression
: logical_and_expression
| logical_or_expression OR_OP logical_and_expression
;

logical_and_expression
: TRUE
| FALSE
| logical_and_expression AND_OP TRUE
| logical_and_expression AND_OP FALSE
;
         
additive_expression
: multiplicative_expression
| additive_expression '+' multiplicative_expression
| additive_expression '-' multiplicative_expression
;

multiplicative_expression
: INTEGER
| multiplicative_expression '*' INTEGER
| multiplicative_expression '/' INTEGER
| multiplicative_expression '%' INTEGER
| '(' additive_expression ')'
;

%%
extern int column;

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    if (yyparse() == 0) {
        printf("success parsing\n");
        return 0;
    }
    return 1;
}

int yyerror(char *s)
{
    fflush(stdout);
    printf("\n%*s\n%*s\n", column, "^", column, s);
    printf("%d\n", column);
    return 1;
}
