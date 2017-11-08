cmake_minimum_required( VERSION 3.5 )
project(valsim)
find_package(FLEX)
find_package(BISON)

BISON_TARGET(parser src/parse.y parse.c)
FLEX_TARGET(lexer src/lex.l lex.c)
