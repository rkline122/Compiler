#include "token.h"
#include <stdio.h>
#include <string.h>

extern FILE *yyin;
extern int yylex();
extern int yylineno;
extern char *yytext;

void string_clean(char *str) {
    size_t len = strlen(str);
    if (len > 1 && str[0] == '"' && str[len-1] == '"' && str[len-2] == 'n' && str[len-3] == '\\') {
        str[len-3] = '\0'; // remove the closing quote and newline
        memmove(str, str+1, len-2); // remove the opening quote
    }
}


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

        if(t == TOKEN_STRING_LITERAL){
            string_clean(yytext);
        }
    
    }

    return 0;
}