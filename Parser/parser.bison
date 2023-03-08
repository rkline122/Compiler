// Literals
%token TOKEN_STRING_LITERAL
%token TOKEN_CHAR_LITERAL
%token TOKEN_FLOAT_LITERAL
%token TOKEN_INT_LITERAL

// Keywords
%token TOKEN_IDENTIFIER

// Arithmetic
%token TOKEN_ADD
%token TOKEN_SUBTRACT
%token TOKEN_MULTIPLY
%token TOKEN_DIVIDE
%token TOKEN_MOD

// Comparison
%token TOKEN_LESS_THAN
%token TOKEN_GREATER_THAN
%token TOKEN_LESS_THAN_OR_EQUAL_TO
%token TOKEN_GREATER_THAN_OR_EQUAL_TO
%token TOKEN_EQUAL_TO
%token TOKEN_NOT_EQUAL_TO
%token TOKEN_AND
%token TOKEN_OR
%token TOKEN_NOT

// Assignments
%token TOKEN_ASSIGNMENT
%token TOKEN_ADD_ASSIGN
%token TOKEN_SUB_ASSIGN
%token TOKEN_MULT_ASSIGN
%token TOKEN_DIVIDE_ASSIGN
%token TOKEN_MOD_ASSIGN

// Brackets
%token TOKEN_LEFT_PAREN
%token TOKEN_RIGHT_PAREN
%token TOKEN_LEFT_BRACKET
%token TOKEN_RIGHT_BRACKET
%token TOKEN_LEFT_CURLY
%token TOKEN_RIGHT_CURLY

// Punctuation
%token TOKEN_SEMICOLON
%token TOKEN_COLON
%token TOKEN_COMMA
%token TOKEN_PERIOD

// Error
%token TOKEN_ERROR

%{
    #include <stdio.h>
    #include <stdlib.h>
    #define YYSTYPE struct expr *
    struct expr * parser_result = 0;

%}

%% 

program:
/* empty */ |
program statement
;

statement:
expression TOKEN_SEMICOLON |
declaration TOKEN_SEMICOLON |
conditional_statement |
loop_statement
;

declaration:
type_specifier TOKEN_IDENTIFIER |
type_specifier TOKEN_IDENTIFIER TOKEN_ASSIGNMENT expression
;

type_specifier:
TOKEN_INT |
TOKEN_FLOAT |
TOKEN_CHAR |
TOKEN_STRING
;

expression:
expression TOKEN_ADD expression |
expression TOKEN_SUBTRACT expression |
expression TOKEN_MULTIPLY expression |
expression TOKEN_DIVIDE expression |
expression TOKEN_MOD expression |
expression TOKEN_LESS_THAN expression |
expression TOKEN_GREATER_THAN expression |
expression TOKEN_LESS_THAN_OR_EQUAL_TO expression |
expression TOKEN_GREATER_THAN_OR_EQUAL_TO expression |
expression TOKEN_EQUAL_TO expression |
expression TOKEN_NOT_EQUAL_TO expression |
expression TOKEN_AND expression |
expression TOKEN_OR expression |
TOKEN_NOT expression |
TOKEN_LEFT_PAREN expression TOKEN_RIGHT_PAREN |
TOKEN_IDENTIFIER |
TOKEN_INT_LITERAL |
TOKEN_FLOAT_LITERAL |
TOKEN_CHAR_LITERAL |
TOKEN_STRING_LITERAL
;

conditional_statement:
TOKEN_IF TOKEN_LEFT_PAREN expression TOKEN_RIGHT_PAREN statement |
TOKEN_IF TOKEN_LEFT_PAREN expression TOKEN_RIGHT_PAREN statement TOKEN_ELSE statement
;

loop_statement:
TOKEN_WHILE TOKEN_LEFT_PAREN expression TOKEN_RIGHT_PAREN statement |
TOKEN_FOR TOKEN_LEFT_PAREN declaration expression TOKEN_SEMICOLON expression TOKEN_RIGHT_PAREN statement
;

%%

// Implement any necessary C code here

int main(void) {
yyparse();
return 0;
}

int yyerror(char const *s) {
printf("Parse error: %s\n", s);
return 0;
}

