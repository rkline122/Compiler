#include "token.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern int yylineno;
extern char *yytext;


int main(){

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
    }

    return 0;
}