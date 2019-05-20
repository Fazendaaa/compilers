%{
    #include <stdio.h>
    #include "./hash.h"

    /*
    * Headers
    */
    int yylex(void);
    void yyerror(char *message);

    /*
     * Stack
     */
    int sym[26];
    hashtable_t *hashtable;
%}

%%

program:
    program statement '\n'
    | /* NULL */
    ;

statement:
    expression                      { printf("%d\n", $1); }
    | /* NULL */
    ;

expression:
    | /* NULL */
    ;

%%

void yyerror(char *message) {
    fprintf(stderr, "%s\n", message);
}

void checkReservedWord(char* yytext){
    if (ht_get( hashtable, yytext )) {
        printf("< %s \t\t| PALAVRA RESERVADA >\n", yytext);
    } else {
        printf("< %s \t\t| ID >\n", yytext);
    }
}

int main(){
    hashtable = ht_create( 65536 );

    ht_set(hashtable, "begin", " ");
    ht_set(hashtable, "end", " ");
    ht_set(hashtable, "real", " ");
    ht_set(hashtable, "integer", " ");
    ht_set(hashtable, "else", " ");
    ht_set(hashtable, "readln", " ");
    ht_set(hashtable, "repeat", " ");
    ht_set(hashtable, "until", " ");
    ht_set(hashtable, "if", " ");
    ht_set(hashtable, "then", " ");
    ht_set(hashtable, "while", " ");
    ht_set(hashtable, "do", " ");
    ht_set(hashtable, "read", " ");
    ht_set(hashtable, "program", " ");
    ht_set(hashtable, "write", " ");
    ht_set(hashtable, "procedure", " ");
    ht_set(hashtable, "var", " ");

    yyparse();

    return 0;
}
