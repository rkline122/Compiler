% {
#include "token.h"
% }
DIGIT [0-9]
LETTER [a-zA-Z]
%%
(" "|\t|\n)                              /* skip whitespace */
(\/\/.+)|"/*"([^*]|(\*+[^*/]))*\*+\/     /* C or C++ Style comments*/
\+                                     { return TOKEN_ADD; }
%%
int yywrap()                            { return 1; }
