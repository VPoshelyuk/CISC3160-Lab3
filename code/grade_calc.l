%{
#include <stdio.h>
#include "y.tab.h"
int c;
extern int yylval;
%}
%%
L|Q|R           {
                    c = yytext[0];
                    yylval = c - 'A';
                    return(LETTER);
                }
P|F             {
                    c = yytext[0];
                    yylval = c - 'A';
                    return(OTHER_ACTIVITY);
                }
T               {
                    c = yytext[0];
                    return(TOTAL);
                }
[0-9]           {   c = yytext[0];
                    yylval = c - '0';
                    return(DIGIT);
                }
[^a-z0-9\b]     {
                    c = yytext[0];
                    return(c);
                }
