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

%token VAR          "var"
%token REAL         "real"
%token INTEGER      "integer"
%token BEGIN        "begin"
%token END          "end"
%token IF           "if"
%token ELSE         "else"
%token THEN         "then"
%token DO           "do"
%token UNTIL        "until"
%token WHILE        "while"
%token REPEAT       "repeat"
%token READLN       "readln"
%token WRITELN      "writeln"
%token PROGRAM      "program"
%token PROCEDURE    "procedure"
%token ERROR        "error"

%%

program:
    PROGRAM statement '\n'
    | /* NULL */
    ;

statement:
    expression                      { printf("%d\n", $1); }
    ;

expression:
    INTEGER
    ;

%%

void yyerror(char *message) {
    fprintf(stderr, "%s\n", message);
}

int checkReservedWord(char* yytext){
    return (ht_get(hashtable, yytext)) ? 1 : 0;
}

void initiateHashTable(void) {
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
}

int main(){
    initiateHashTable();
    yyparse();

    return 0;
}
