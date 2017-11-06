%{
#include <stdio.h>
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

%token R_PARENTH
%token L_PARENTH

%token FOR
%token WHILE
%token IF
%token <itype> INTEGER
%token <dtype> FLOAT
%token <str> IDENT

%left PLUS MINUS
%left MULT DIV

%%
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
int main()
{
    if (yyparse() == 0) {
        printf("success parsing");
        return 0;
    }
    return 1;
}

int yyerror(char *s)
{
    printf("%s\n",s);
    return 1;
}
