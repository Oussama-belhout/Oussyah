%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "synt.tab.h"
extern YYSTYPE yylval;
extern int nb_line;
extern int col;
#include "ts_ll.h"
%}

lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_)*
cst {chiffre}+
int_val [+-]?{chiffre}+
real_val [+-]?{chiffre}+"."[0-9]+
string_val \"[^\"]*\"
bool_val [TRUE|FALSE]

%%
"INTEGER"   {yylval.str = strdup(yytext); insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return integer;}
"CHARACTER" {yylval.str = strdup(yytext); insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return character;}
"REAL"      {yylval.str = strdup(yytext); insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return real;}
"LOGICAL"   {yylval.str = strdup(yytext); insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return logical;}
"PROGRAM"   {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return program;} 
"END"       {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return end;}
"IF"        {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return si;} 
"THEN"      {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return then;}
"ELSE"      {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return sinon;}
"ENDIF"     {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return endif;}
"DOWHILE"   {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return dowhile;}
"ENDDO"     {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return enddo;}
"READ"      {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return read;}
"WRITE"     {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return write;}
"CALL"      {insert(yytext,  "mot cle", "", 0, 2); col = col + yyleng; return call;}
"ROUTINE"   {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return routine;}
"ENDR"      {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return endr;}
"DIMENSION" {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return dimension;}
"EQUIVALENCE" {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return equivalence;}
".EQ."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return eq;}
".GT."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return gt;}
".GE."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return ge;}
".NE."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return ne;}
".LE."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return le;}
".LT."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return lt;}
".OR."  {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return ou;}
".AND." {insert(yytext, "mot cle", "", 0, 2); col = col + yyleng; return et;}
"("   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return gparen;}
")"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return dparen;}
";"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return sc;}
","   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return cm;}
"+"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return plus;}
"-"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return minus;}
"*"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return mult;}
"/"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return divis;}
":"   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return dp;}
"="   {insert(yytext, "separateur", "", 0, 1); col = col + yyleng; return egale;}

{IDF} { yylval.str = strdup(yytext);
         insert(yytext, "IDF", "", 0, 0);
         col = col + yyleng;		 
         if(strlen(yytext) > 10) {
          printf("Warning: Identificateur a la ligne %d colonne %d depasse 10 caracteres.\n", nb_line, col, yytext);
         }
       return id; 
      }
{cst} { yylval.integer = atoi(yytext); insert(yytext, "CONSANT", "INTEGER",atoi(yytext), 0); 
            col = col + yyleng; 
	        return cst; 
		   }
{int_val} { yylval.integer = atoi(yytext); insert(yytext, "ENTIER", "INTEGER",atoi(yytext), 0); 
            col = col + yyleng; 
            if(atoi(yytext) < -32768 | atoi(yytext) > 32767) 
		    printf("\nWarning: a la ligne %d colonne %d Le nombre %s depasse l'intervalle des entiers\n", nb_line, col, yytext);
            else 
	        return int_val; 
		   }
{real_val} { yylval.real = atof(yytext); insert(yytext, "FLOAT","REAL",atof(yytext), 0); 
            col = col + yyleng;
			if(atoi(yytext) < -32768 | atoi(yytext) > 32767) 
		    printf("\nWarning: a la ligne %d colonne %d Le nombre %s depasse l'intervalle des entiers\n", nb_line, col, yytext);
            else 
			return real_val; 
		   }
{bool_val} { col = col + yyleng; return bool_val; }
{string_val} { col = col + yyleng; return str_val; }

"%"[^\n]* { col = col + yyleng; } //printf("Commentaire reconnu\n"); Ignorer les commentaires
[ \t] { col = col + yyleng; }
\n { col = 1 ; nb_line++;} 
. {printf("\nErreur lexicale : %s a ligne %d colonne %d \n", yytext, nb_line, col); col = col + yyleng;}
