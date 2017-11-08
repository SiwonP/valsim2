cmake_minimum_required( VERSION 3.5 )
project(valsim)
find_package(FLEX)
find_package(BISON)

BISON_TARGET(parser src/parse.y src/parse.c)
FLEX_TARGET(lexer src/lex.l src/lex.c)

add_executable(
    valsim
    ${BISON_parser_OUTPUTS}
    ${FLEX_lexer_OUTPUTS}
)
