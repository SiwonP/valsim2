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

%token FOR
%token WHILE
%token IF
%token <itype> INTEGER
%token <dtype> FLOAT
%token <str> IDENT

%left '+' '-' 
%left '*' '/'

%%
expression:     expression'+'INTEGER 
            |   expression '-' INTEGER
            |   INTEGER
            ;
%%
int main()
{
    return yyparse();
}

int yyerror(char *s)
{
    printf("%s\n",s);
    return 1;
}
