% {
#include "token.h" 
% }
DIGIT [0-9]
LETTER [a-zA-Z]
%%
^#[ \t]*(include|define|undef|ifdef|ifndef|if|elif|else|endif|error|pragma)[ \t]+.*     { return TOKEN_PREPROCESSOR }
(" "|\t|\n)                                                                             /* skip whitespace */
(\/\/.+)|"/*"([^*]|(\*+[^*/]))*\*+\/                                                    /* C or C++ Style comments*/
\b[a-zA-Z_][a-zA-Z0-9_]*\b                                                              { return TOKEN_KEYWORD_OR_IDENTIFIER }
\"([^"\\]|\\.|\\\n)*\"                                                                  {   
                                                                                            if (strlen(yytext) > 160) {
                                                                                                fprintf(stderr, "scan error: string is longer than 160 characters\n"); return TOKEN_ERROR;
                                                                                            }
                                                                                            return TOKEN_STRING_LITERAL;
                                                                                        }
'(\\?.?)'                                                                               {   
                                                                                            if (!strcmp(yytext, "''")) {fprintf(stderr, "scan error: cannot have empty character\n"); return TOKEN_ERROR;}
                                                                                            else if (!strcmp(yytext, "'\\'")) {fprintf(stderr, "scan error: invalid character\n"); return TOKEN_ERROR;}
                                                                                            
                                                                                            char BUFF[160];
                                                                                            // stripping single quotes
                                                                                            for (int i = 0; i < strlen(yytext); i++) {
                                                                                                BUFF[i] = yytext[i + 1];
                                                                                            }
                                                                                            BUFF[strlen(yytext) - 2] = '\0';

                                                                                            // stripping slashes
                                                                                            if (BUFF[0] == '\\') { // starts with backslash
                                                                                                if  ((BUFF[1] == 'n') || (BUFF[1] == '0') || (BUFF[1] == '\\')) { // is a special character
                                                                                                    return TOKEN_CHAR_LITERAL;
                                                                                                }
                                                                                                else {// is  like any other character
                                                                                                    return TOKEN_CHAR_LITERAL;
                                                                                                }
                                                                                            }
                                                                                            
                                                                                            return TOKEN_CHAR_LITERAL;        
                                                                                        }
{DIGIT}+                                                                                {
                                                                                            if (strtol(yytext, NULL, 10) == LONG_MIN)        {fprintf(stderr, "scan error: integer underflow\n"); return TOKEN_ERROR;}
                                                                                            else if (strtol(yytext, NULL, 10) == LONG_MAX)   {fprintf(stderr, "scan error: integer overflow\n"); return TOKEN_ERROR;}
                                                                                            else {
                                                                                                return TOKEN_INT_LITERAL;
                                                                                            }
                                                                                        }                                       
({LETTER}|_)(({LETTER}|{DIGIT}|_)*)                                                     {   
                                                                                            /*Starts w/ letter or underscore, ends with letter  underscore or digit*/
                                                                                            if (strlen(yytext) > 160) {
                                                                                                fprintf(stderr, "scan error: identifier longer than 160 characters\n"); 
                                                                                                return TOKEN_ERROR;
                                                                                            }
                                                                                            return TOKEN_IDENT;       
                                                                                        } 
\+                                                                                      { return TOKEN_ADD; }
\-                                                                                      { return TOKEN_SUBTRACT; }
\*                                                                                      { return TOKEN_MULTIPLY; }
\/                                                                                      { return TOKEN_DIVIDE; }
\*                                                                                      { return TOKEN_MOD; }
\<                                                                                      { return TOKEN_LESS_THAN; }
\>                                                                                      { return TOKEN_GREATER_THAN; }
\<\=                                                                                    { return TOKEN_LESS_THAN_OR_EQUAL_TO; }
\>\=                                                                                    { return TOKEN_GREATER_THAN_OR_EQUAL_TO; }
\=\=                                                                                    { return TOKEN_EQUAL_TO; }
\!\=                                                                                    { return TOKEN_NOT_EQUAL_TO; }
&&                                                                                      { return TOKEN_AND; }
\|\|                                                                                    { return TOKEN_OR; }
!                                                                                       { return TOKEN_NOT; }
\=                                                                                      { return TOKEN_ASSIGNMENT; }
\+=                                                                                     { return TOKEN_ADD_ASSIGN; }
\-=                                                                                     { return TOKEN_SUB_ASSIGN; }
\*=                                                                                     { return TOKEN_MULT_ASSIGN; }
\/=                                                                                     { return TOKEN_DIVIDE_ASSIGN; }
%=                                                                                      { return TOKEN_MOD_ASSIGN; }
\(                                                                                      { return TOKEN_LEFT_PAREN;   }
\)                                                                                      { return TOKEN_RIGHT_PAREN;  }
\[                                                                                      { return TOKEN_LEFT_BRACKET; }
\]                                                                                      { return TOKEN_RIGHT_BRACKET;}
\{                                                                                      { return TOKEN_LEFT_CURLY;   }
\}                                                                                      { return TOKEN_RIGHT_CURLY;  }
;                                                                                       { return TOKEN_SEMICOLON;    }
:                                                                                       { return TOKEN_COLON;        }
,                                                                                       { return TOKEN_COMMA;        }
.                                                                                       { fprintf(stderr, "scan error: %s is an invalid token\n", yytext); return TOKEN_ERROR;       }
%%
int yywrap()                                                                            { return 1; }
