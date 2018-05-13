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

%token D_VECTOR
%token D_MATRIX
%token D_INT
%token D_FLOAT

%token FOR
%token WHILE
%token IF
%token ELSE

%token FUNCTION

%token <itype> INTEGER
%token <dtype> FLOAT
%token <str> IDENT

%left '+' '-' OR_OP
%left '*' '/' AND_OP

%start unit

%%

unit
: declaration
;

declaration
: statement_list
;

statement_list
: statement
| statement_list statement
;

statement
: expression_statement
| selection_statement
| iteration_statement
| compound_statement
;

selection_statement
: IF '(' expression ')' statement
| IF '(' expression ')' ELSE statement
;

iteration_statement
: FOR '(' expression_statement expression_statement expression ')' statement
| WHILE '(' expression ')' statement
;
compound_statement
: '{' '}'
| '{' statement_list '}'
;

expression_statement
: ';'
| expression ';'
;

expression
: assignement_expression
| expression ',' assignement_expression
;

assignement_expression
: logical_or_expression
| declarative_word unary_expression '=' assignement_expression
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
| vector
| matrix
;

vector
: '[' float_vector ']'
;

float_vector
: FLOAT
| float_vector ',' FLOAT
;

matrix
: '[' matrix_row ']'
;

matrix_row
: vector
| matrix_row ',' vector
;

declarative_word
: D_MATRIX
| D_VECTOR
| D_FLOAT
| D_INT
;

%%
extern int column;
extern int line;

int main(int argc, char *argv[])
{
    yyin = fopen(argv[1], "r");
    if (yyparse() == 0) {
        printf("\nSuccess parsing !\n");
        return 0;
    }
    return 1;
}

int yyerror(char *s)
{
    fflush(stdout);
    printf("\n%*s\n%*s\n", column, "^", column, s);
    printf("%s in column %d of line %d\n", s, column, line);
    return 1;
}
