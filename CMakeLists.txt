cmake_minimum_required( VERSION 3.5 )
project(valsim)
find_package(FLEX)
find_package(BISON)

BISON_TARGET(parser src/parse.y ${CMAKE_CURRENT_BINARY_DIR}/parse.c COMPILE_FLAGS -d)
FLEX_TARGET(lexer src/lex.l ${CMAKE_CURRENT_BINARY_DIR}/lex.c)

add_executable(
    valsim
    ${BISON_parser_OUTPUTS}
    ${FLEX_lexer_OUTPUTS}
)
