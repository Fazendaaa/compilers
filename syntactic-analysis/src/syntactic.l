%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    /*
    * Headers
    */
    void yyerror(char *message);
    int checkReservedWord(char *yytext);
%}

NUMERO [0-9]
_REAL {NUMERO}+"."{NUMERO}+
PALAVRA [a-zA-Z][a-zA-Z0-9_]*
NEW_LINE \n
TAB \t
SPACE [ ]
COMENTARIO [{].+[}]
COMENTARIO_ABERTO "{"[^}]*
NUM_ERRADO ([0-9]+\.[0-9]*[a-zA-Z]+([0-9]|[a-zA-Z])*|[0-9]*[a-zA-Z]+([0-9]|[a-zA-Z])*\.[0-9]+|[0-9]+[a-zA-Z]+([0-9]|[a-zA-Z])*)

%%

{NUMERO}+           {
                        printf("< %d \t\t| INTEGER >\n", atoi(yytext));

                        return INTEGER;
                    }

{_REAL}             {
                        printf("< %f \t\t| REAL >\n", atof(yytext));

                        return REAL;
                    }

"*"                 {
                        printf("< %s \t\t| MULTIPLICATION >\n", yytext);
                        printSymbol(yytext, "MULTIPLICATION");

                        return MULTIPLICATION;
                    }

"/"                 {
                        printf("< %s \t\t| SIMB_DIV >\n", yytext);
                        printSymbol(yytext, "DIVISION");

                        return DIVISION;
                    }

"+"                 {
                        printf("< %s \t\t| SIMB_MAS >\n", yytext);
                        printSymbol(yytext, "ADD");

                        return ADD;
                    }

"-"                 {
                        printf("< %s \t\t| SIMB_MENOS >\n", yytext);
                        printSymbol(yytext, "SUBTRACT");

                        return SUBTRACT;
                    }

"("                 {
                        printf("< %s \t\t| SIMB_PAA >\n", yytext);
                        printSymbol(yytext, "OPEN_PARENTESIS");

                        return OPEN_PARENTESIS;
                    }

")"                 {
                        printf("< %s \t\t| SIMB_PAC >\n", yytext);
                        printSymbol(yytext, "CLOSE_PARENTESIS");

                        return CLOSE_PARENTESIS;
                    }

":"                 {
                        printf("< %s \t\t| SIMB_DOIS_PTOS >\n", yytext);
                        printSymbol(yytext, "TWO_POINTS");

                        return TWO_POINTS;
                    }

"."                 {
                        printf("< %s \t\t| SIMB_PTO >\n", yytext);
                        printSymbol(yytext, "POINT");

                        return POINT;
                    }

">"                 {
                        printf("< %s \t\t| SIMB_MAIOR >\n", yytext);
                        printSymbol(yytext, "GREATER");

                        return GREATER;
                    }

"<"                 {
                        printf("< %s \t\t| SIMB_MENOR >\n", yytext);
                        printSymbol(yytext, "LESSER");

                        return LESSER;
                    }

","                 {
                        printf("< %s \t\t| SIMB_VIRGULA >\n", yytext);
                        printSymbol(yytext, "COMMA");

                        return COMMA;
                    }

"\""                {
                        printf("< %s \t\t| SIMB_ASPAS >\n", yytext);
                        printSymbol(yytext, "ASPAS");

                        return ASPAS;
                    }

"&&"                {
                        printf("< %s \t\t| SIMB_AND >\n", yytext);
                        printSymbol(yytext, "AND");

                        return AND;
                    }

"||"                {
                        printf("< %s \t\t| SIMB_OR >\n", yytext);
                        printSymbol(yytext, "OR");

                        return OR;
                    }

"cos"               {
                        printf("< %s \t\t| TKN_COS >\n", yytext);
                        printSymbol(yytext, "COS");

                        return COS;
                    }

"sen"               {
                        printf("< %s \t\t| TKN_SEN >\n", yytext);
                        printSymbol(yytext, "SIN");

                        return SIN;
                    }

{PALAVRA}           {
                        if (checkReservedWord(yytext)) {
                            printf("< %s \t\t| PALAVRA RESERVADA >\n", yytext);

                            return RESERVED;
                        }

                        printf("< %s \t\t| ID >\n", yytext);

                        return ID;
                    }

{COMENTARIO_ABERTO} printf("\n\n< ERRO: COMENTARIO ABERTO >\n\n");

{NUM_ERRADO}        printf("\n\n< ERRO: TOKEN MAL FORMADO >\n\n");

{NEW_LINE}          ; /* skip */

{TAB}               ; /* skip */

{SPACE}             ; /* skip */

{COMENTARIO}        ; /* skip */

.                   yyerror("Caracter desconhecido");
%%

int yywrap(void) {
    return 1;
}

int printSymbol(const char * symbol, const char * kind) {
    printf("< %s \t\t| %s >\n", symbol, kind);

    return 1;
}
