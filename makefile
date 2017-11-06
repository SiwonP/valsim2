LEX = flex
YACC = bison
CC = gcc

all: lex.c parse.c parse.h
	gcc -o compil lex.c parse.c 

parse.c: parse.y
	bison -d -o parse.c parse.y

lex.c: lex.l
	flex -o lex.c lex.l
