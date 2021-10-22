%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
extern FILE* yyin;
%}
%union {
int integer;
float flt;
char chr;
char *str;
}
%left PLUS MOINS
%left MUL DIV

%token PROGRAM Begin END var INTEGER FLOAT CHAR STRING CONST Let GET SHOW IF RETURN ELSE ENDIF FOR END_FOR
%token <str> idf 
%token <integer> TOK_INTEGER 
%token <flt> TOK_FLOAT
%token <chr> TOK_CHAR
%token <str> TOK_STRING
%token  EURO PO PF DAPOS APOS HASH DOLLAR MOD ET DPTS AROBASE CBO CBF CROCHETO CROCHETF
%token  DPIP DIV MUL DEF INFEG SUPEG MOINS PLUS INF SUP EGALE
%token '='
%start program
%%
program: PROGRAM idf CORPS {printf ("programme correcte\n");};

CORPS: dec_var Begin trait END;

dec_var: var liste_var DPTS type EURO {printf ("declaration correcte\n");} dec_var
         |Let idf type '=' valeur EURO {printf ("declaration correcte\n");} dec_var
         |var idf CROCHETO TOK_INTEGER CROCHETF DPTS CROCHETO type CROCHETF EURO  {printf ("declaration correcte\n");} dec_var
         |;
liste_var: idf liste_var
          |DPIP idf liste_var
          |;

valeur: TOK_INTEGER
        | TOK_FLOAT
        | TOK_CHAR
        | TOK_STRING;

type: INTEGER
     | FLOAT
     | CHAR
     | STRING;

trait: affectation
       | entree
       | sortie
       | if_cond
       | for_boucle;
       

affectation: idf '=' exp EURO {printf ("affectation correcte\n");}trait;
exp: exp PLUS exp
     |exp MOINS exp
     |exp MUL exp
     |exp DIV exp
     |PO exp PF
     |TOK_INTEGER
     |TOK_FLOAT
     |TOK_CHAR
     |TOK_STRING
     |idf;
entree: GET PO DAPOS signe_for DAPOS DPTS AROBASE idf PF EURO {printf ("expression get correcte\n");} trait;
sortie: SHOW PO DAPOS idf signe_for DAPOS DPTS idf PF EURO {printf ("expression show correcte\n");} trait;
signe_for: HASH | DOLLAR | MOD | ET;
 
if_cond: IF PO cond PF DPTS CBO trait return_statement CBF ELSE DPTS CBO trait return_statement CBF ENDIF if_cond {printf ("if cond correcte\n");} trait
         |IF PO cond PF DPTS CBO  imbr EURO return_statement CBF ELSE CBO imbr EURO return_statement CBF ENDIF if_cond {printf ("if cond correcte\n");} trait
         |;
cond: exp DEF exp
     | exp INF exp
     | exp SUP exp
     | exp INFEG exp
     | exp SUPEG exp
     | exp EGALE exp;

bloc_instr: affectation bloc_instr
            |entree bloc_instr
            |sortie bloc_instr
            |return_statement;

return_statement: RETURN PO idf PF EURO {printf ("return correcte\n");}
                  |RETURN PO valeur PF EURO {printf ("return correcte\n");};

for_boucle: FOR PO idf DPTS TOK_INTEGER DPTS cond PF bloc_for END_FOR {printf ("boucle for correcte\n");} trait
           |FOR PO idf DPTS TOK_INTEGER DPTS imbr PF bloc_for END_FOR {printf ("boucle for correcte\n");} trait;
bloc_for: affectation bloc_for
         |entree bloc_for
         |sortie bloc_for
         |;
 
imbr: for_boucle
      |if_cond;

%%
int yyerror(char* msg)
{
printf("%s\n",msg);
return 1;
}
int main()
{
yyin=fopen("nabil.txt","r");
yyparse();
return 0;
}
