%{
#include "parse.h"
%}

%option noyywrap

INTEGER [0-9]+
FLOAT   [0-9]+\.[0-9]*
IDENT   [a-zA-Z_][0-9a-zA-Z_]*

%%

")"             { return R_PARENTH; }
"("             { return L_PARENTH; }
"*"             { return MULT; }
"/"             { return DIV; }
"-"             { return MINUS; }
"+"             { return PLUS; }
"for"           { printf("%s\n", yytext); return FOR; }
"while"         { printf("%s\n", yytext); return WHILE; }
"if"            { printf("%s\n", yytext); return IF; }
{INTEGER}       { return INTEGER; }
{FLOAT}         { return FLOAT; }
{IDENT}         { return IDENT; }
[ \t]+          { /* nothing to do */ } 

%%
