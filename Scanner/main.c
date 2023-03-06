#include "token.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern int yylineno;
extern char *yytext;


int main(){

    const char *token_names[] = {
        "TOKEN_EOF",
        "TOKEN_PREPROCESSOR",
        "TOKEN_IMPORT",
        "TOKEN_STRING_LITERAL",
        "TOKEN_CHAR_LITERAL",
        "TOKEN_FLOAT_LITERAL",
        "TOKEN_INT_LITERAL",
        "TOKEN_PERIOD",
        "TOKEN_IDENT",
        "TOKEN_ADD",
        "TOKEN_SUBTRACT",
        "TOKEN_MULTIPLY",
        "TOKEN_DIVIDE",
        "TOKEN_MOD",
        "TOKEN_LESS_THAN",
        "TOKEN_GREATER_THAN",
        "TOKEN_LESS_THAN_OR_EQUAL_TO",
        "TOKEN_GREATER_THAN_OR_EQUAL_TO",
        "TOKEN_EQUAL_TO",
        "TOKEN_NOT_EQUAL_TO",
        "TOKEN_AND",
        "TOKEN_OR",
        "TOKEN_NOT",
        "TOKEN_ASSIGNMENT",
        "TOKEN_ADD_ASSIGN",
        "TOKEN_SUB_ASSIGN",
        "TOKEN_MULT_ASSIGN",
        "TOKEN_DIVIDE_ASSIGN",
        "TOKEN_MOD_ASSIGN",
        "TOKEN_LEFT_PAREN",
        "TOKEN_RIGHT_PAREN",
        "TOKEN_LEFT_BRACKET",
        "TOKEN_RIGHT_BRACKET",
        "TOKEN_LEFT_CURLY",
        "TOKEN_RIGHT_CURLY",
        "TOKEN_SEMICOLON",
        "TOKEN_COLON",
        "TOKEN_COMMA",
	    "TOKEN_ERROR"
    };


    yyin = fopen("program.c", "r");
    if (!yyin) {
        printf("Could not open program.c\n");
        return 1;
    }

    while (1) {
        token_t t = yylex();
        if (t == TOKEN_EOF) {
            break;
        }
       printf("token: %s text: %s\n", token_names[t], yytext);
    }
}