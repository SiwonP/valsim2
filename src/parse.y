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

expression
: assignement_expression
| expression ',' assignement_expression
;

assignement_expression
: logical_or_expression
| LET unary_expression '=' assignement_expression
;

logical_or_expression
: logical_and_expression
| logical_or_expression OR_OP logical_and_expression
;

logical_and_expression
: equality_expression
| logical_and_expression AND_OP equality_expression
;

equality_expression
: relational_expression
| equality_expression EQ_OP relational_expression
| equality_expression NE_OP relational_expression
;

relational_expression
: additive_expression
| relational_expression '<' additive_expression
| relational_expression '>' additive_expression
| relational_expression LE_OP additive_expression
| relational_expression GE_OP additive_expression
;

additive_expression
: multiplicative_expression
| additive_expression '+' multiplicative_expression
| additive_expression '-' multiplicative_expression
;

multiplicative_expression
: unary_expression
| multiplicative_expression '*' unary_expression
| multiplicative_expression '/' unary_expression
| multiplicative_expression '%' unary_expression
| '(' additive_expression ')'
;

unary_expression
: IDENT
| INTEGER
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
