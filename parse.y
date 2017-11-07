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

%token PLUS
%token MINUS
%token MULT
%token DIV

%token OR
%token AND

%token TRUE
%token FALSE

%token R_PARENTH
%token L_PARENTH

%token LET
%token SEMICOLON
%token EGAL
%token QUOTE

%token FOR
%token WHILE
%token IF
%token <itype> INTEGER
%token <dtype> FLOAT
%token <str> IDENT

%left PLUS MINUS OU
%left MULT DIV ET

%%
declar_var: LET var SEMICOLON
        |   LET affect_var
        ;

affect_var: var EGAL exp SEMICOLON
        ;

var:        IDENT
        ;

exp:        a_exp
        ;

a_exp:      a_exp PLUS a_term 
        |   a_term
        ;

a_term:     a_term MULT a_factor
        |   a_factor
        ;

a_factor:   L_PARENTH a_exp R_PARENTH
        |   INTEGER
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
