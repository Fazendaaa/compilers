%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "./hash.h"

/*
 * Headers
 */
void yyeror(char *message);
%}

%%

program:
    function        { exit(0); }
    ;

function:
    function stmt   {}
    | /* NULL */
    ;

%%

void yyeror(char *message) {
    fiprintf(stdout, "%s\n", message);
}

int main(void) {
    yyparse();

    return 0;
}
