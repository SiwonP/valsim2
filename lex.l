%{
#include "parse.h"
%}

%option noyywrap

INTEGER [0-9]+
FLOAT   [0-9]+\.[0-9]*
IDENT   [a-zA-Z_][0-9a-zA-Z_]*

%%

"true"          { return TRUE; }
"false"         { return FALSE; }
"&&"            { return AND_OP; }
"||"            { return OR_OP; }
"let"           { return LET; }
"="             { return '='; }
";"             { return ';'; }
")"             { return '('; }
"("             { return ')'; }
"*"             { return '*'; }
"/"             { return '/'; }
"%"             { return '%'; }
"-"             { return '-'; }
"+"             { return '+'; }
"for"           { return FOR; }
"while"         { return WHILE; }
"if"            { return IF; }
"else"          { return ELSE; }
{INTEGER}       { return INTEGER; }
{FLOAT}         { return FLOAT; }
{IDENT}         { return IDENT; }
[ \t\n]+          { /* nothing to do */ } 

%%
