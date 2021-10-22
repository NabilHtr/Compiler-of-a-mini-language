#ifndef lay
#define lay
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
 
typedef struct
{
int state;
char name[20];
char type[20];
int val;
} element;
typedef struct
{
int state;
char name[20];
char type[20];
} elt;

element tab[1000];
elt tabs[40];
elt tabm[40];

void init()
{

 int i,j;
 for (i=0;i<1000;i++){
   tab[i].state=0;
  }
  for (j=0;j<40;j++)
{
  tabs[j].state=0;
  tabm[j].state=0;
}
}

void inserer (char entite[], char type[],int val, int i, int y)
{
switch (y)
{ case 0: /*insertion dans la table des IDF et CONST*/
  tab[i].state=1;
  strcpy (tab[i].name, entite);
  strcpy (tab[i].type, type);
  tab[i].val=val;
  break;
  case 1: /*insertion dans la table des mots clés*/
  tabm[i].state=1;
  strcpy (tabm[i].name,entite);
  strcpy (tabm[i].type,type);
  break;
  case 2: /*insertion dans la table des séparateurs*/
  tabs[i].state=1;
  strcpy (tabs[i].name,entite);
  strcpy (tabs[i].type,type);
break;
}
}
void recherche (char entite[ ], char type [ ], int val, int y)
{
int j,i;
switch (y)
{
 case 0: /*verifier si la case dans la tables des IDF et CONST est libre*/
  for (i=0;(((i<1000)&&(tab[i].state==1))&&(strcmp(entite,tab[i].name)!=0));i++);
   if(i<1000) inserer ( entite, type, val, i, 0);
  else printf("entité existe déjà\n");
break;
case 1: /*verifer si la case dans la tables des mots clés est libre*/
  for (i=0;(((i<40)&&(tabm[i].state==1)) &&(strcmp(entite,tab[i].name)!=0));i++);
  if (i<40) inserer(entite,type,val,i,1);
  else printf ("entité existe déjà\n");
break;
case 2: /*verifer si la case dans la tables des séparateurs estlibre*/
 for (i=0;(((i<40)&&(tabs[i].state==1))&&(strcmp(entite,tab[i].name)!=0));i++);
if(i<40) inserer(entite,type,val,i,2);
 else printf("entité existe déjà\n");
break;
} // fn switch
}
void affiche(){
int i,j,k;
for (i=0;i<1000;i++){
 if (tab[i].state==1){
 printf("name: %s\t ,type: %s\t ,val: %d\n",tab[i].name,tab[i].type,tab[i].val);
}
}
for (j=0;j<40;j++){
if(tabs[j].state==1){
 printf("name: %s\t ,type: %s\n ",tabs[j].name,tabs[j].type);
}
}
for (k=0;k<40;k++){
if(tabm[k].state==1){
 printf("name: %s\t ,type: %s\n ",tabm[k].name,tabm[k].type);
}
}
}
#endif
