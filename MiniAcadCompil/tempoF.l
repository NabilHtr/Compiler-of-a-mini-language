%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"tempoF.tab.h"
#include"lay.h"
int nb_ligne=1;
int col=1;
extern YYSTYPE yylval;

%}
 
MOT_CLE PROGRAM|BEGIN|END|var|INTEGER|FLOAT|CHAR|STRING|CONST|Let|GET|SHOW|IF|RETURN|ELSE|ENDIF|FOR|END_FOR
INTEGER [-+]?[0-9]+[0-9]*
FLOAT [+-]?[0-9]+"."[0-9]+[1-9]*	
CHAR "'"[a-zA-Z]"'"|"'"[0-9]"'"
STRING ["][a-zA-Z" "]+[0-9a-zA-Z" "]*["]
idf [A-Z]([a-zA-Z]|[0-9])*
operateur "=="|">>"|"<<"|"+"|"-"|"="|">>="|"<<="|"<<>>"|"*"|"/"
CARA_SPE "||"|"£"|"("|")"|["]|"'"|"#"|"$"|"%"|"&"|":"|"@"|"{"|"}"|"["|"]"
SPACE " "
CMNT1 "//".*"//"

%%
PROGRAM {printf("PROGRAM\n");
return PROGRAM;}
BEGIN {printf("BEGIN\n");
return Begin;}
END {printf("END\n");
return END;}
var {printf("var\n");
return var;}
INTEGER {printf("INTEGER\n");
return INTEGER;}
FLOAT {printf("FLOAT\n");
return FLOAT;}
CHAR {printf("CHAR\n");
return CHAR;}
STRING {printf("STRING\n");
return STRING;}
CONST {printf("CONST\n");
return CONST;}
Let {printf("Let\n");
return Let;}
GET {printf("GET\n");
return GET;}
SHOW {printf("SHOW\n");
return SHOW;}
IF {printf("IF\n"); return IF;}
RETURN {printf("RETURN\n"); return RETURN;}
ELSE {printf("ELSE\n"); return ELSE;}
ENDIF {printf("ENDIF\n"); return ENDIF;}
FOR {printf("FOR\n"); return FOR;}
END_FOR {printf("END_FOR\n"); return END_FOR;}
"==" {printf("==\n"); return EGALE;}
">>" {printf(">>\n"); return SUP;}
"<<" {printf("<<\n"); return INF;}
"+" {printf("+\n"); return PLUS;}
"-" {printf("-\n"); return MOINS;}
">>=" {printf(">>=\n"); return SUPEG;}
"<<=" {printf("<<=\n"); return INFEG;}
"<<>>" {printf("<<>>\n"); return DEF;}
"*" {printf("*\n"); return MUL;}
"/" {printf("/ \n"); return DIV;}
"=" {printf("=\n"); return '=';}
"||" {printf("||\n"); return DPIP;}
"£" {printf("£\n"); return EURO;}
"(" {printf("(\n"); return PO;}
")" {printf(")\n"); return PF;}
["] {printf("''\n"); return DAPOS;} 
"'" {printf("'\n"); return APOS;}
"#" {printf("#\n"); return HASH;}
"$" {printf("$\n"); return DOLLAR;}
"%" {printf("%\n"); return MOD;} 
"&" {printf("&\n"); return ET;}
":" {printf(":\n"); return DPTS;}
"@" {printf("@\n"); return AROBASE;}
"{" {printf("{\n"); return CBO;}
"}" {printf("}\n"); return CBF;}
"[" {printf("[\n"); return CROCHETO;}
"]" {printf("]\n"); return CROCHETF;}
"\n" {printf("saut de ligne\n"); nb_ligne++;col=0;}
 
 
  /*{MOT_CLE} {printf("%s est un MOT CLE\n",yytext);
recherche (yytext," ",strlen(yytext),1);
col = col + strlen(yytext);
}*/
{INTEGER} {printf("%s est un entier  \n",yytext);

recherche (yytext,"entier",strlen(yytext),0);
col = col + strlen(yytext);
yylval.integer=atoi(yytext);
return TOK_INTEGER;
}
{FLOAT} {printf("%s est un FLOAT\n",yytext);

recherche (yytext,"float",strlen(yytext),0);
col = col + strlen(yytext);
yylval.flt=atoi(yytext);
return TOK_FLOAT;
}
{CHAR} {printf("%s est un CHAR\n",yytext);

recherche (yytext,"char",1,0);
col = col + strlen(yytext);
yylval.chr=strdup(yytext);
return TOK_CHAR;
}
{STRING} {printf("%s est un STR\n",yytext);

recherche (yytext,"string",strlen(yytext),0);
col = col + strlen(yytext);
yylval.str=strdup(yytext);
return TOK_STRING;
}
{idf} {printf("%s est un idf\n",yytext);

recherche(yytext," ",0,0);
col = col + strlen(yytext);
yylval.str=strdup(yytext);
return idf;
}
  /*{operateur} {printf("%s est un op\n",yytext);

recherche (yytext,"ope",0,2);
col=col+strlen(yytext);}

{CARA_SPE} {printf("%s est un caractere speciale\n",yytext);

recherche (yytext,"cara_spe",0,2);
col=col+strlen(yytext);
}*/
{CMNT1} {printf("%s est un commentaire\n",yytext);
col=col+strlen(yytext);}

{SPACE} {printf(" ");
col=col+strlen(yytext);}

. {col=col+strlen(yytext);
printf("erreur a la ligne %d \t et colonne %d \t",nb_ligne,col);
printf("(%s) N'est pas reconnu dans ce langage !\n",yytext); } 
%%
int yywrap(void)
{
return 1;
}
 /*   int main()
{init();
yyin = fopen( "input.txt", "r" );
if (yyin==NULL) printf("ERROR \n");
else yylex();
affiche();
return 0;
}*/
