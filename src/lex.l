%{
#include "parse.h"
void count();
%}

%option noyywrap

INTEGER [0-9]+
FLOAT   [0-9]+\.[0-9]*
IDENT   [a-zA-Z_][0-9a-zA-Z_]*

%%

"true"          { count(); return TRUE; }
"false"         { count(); return FALSE; }
"&&"            { count(); return AND_OP; }
"||"            { count(); return OR_OP; }
"!"             { count(); return '!'; }
"<="            { count(); return LE_OP; }
">="            { count(); return GE_OP; }
"<"             { count(); return '<'; }
">"             { count(); return '>'; }
"=="            { count(); return EQ_OP; }
"!="            { count(); return NE_OP; }
"let"           { count(); return LET; }
"="             { count(); return '='; }
";"             { count(); return ';'; }
")"             { count(); return '('; }
"("             { count(); return ')'; }
"{"             { count(); return '{'; }
"}"             { count(); return '}'; }
"*"             { count(); return '*'; }
"/"             { count(); return '/'; }
"%"             { count(); return '%'; }
"-"             { count(); return '-'; }
"+"             { count(); return '+'; }
"for"           { count(); return FOR; }
"while"         { count(); return WHILE; }
"if"            { count(); return IF; }
"else"          { count(); return ELSE; }
{INTEGER}       { count(); return INTEGER; }
{FLOAT}         { count(); return FLOAT; }
{IDENT}         { count(); return IDENT; }
[ \t\n]+        { count();/* nothing to do */ }

%%

int column = 0;

void count()
{
    int i;
    for (i = 0; yytext[i] != '\0'; i++) {
        printf("%c", yytext[i]);
        if (yytext[i] == '\n') {
            column = 0;
        } else if (yytext[i] == '\t') {
            column += 4;
        } else {
            column++;
        }
    }
}
