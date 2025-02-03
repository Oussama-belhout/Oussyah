#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// la table des symboles des identificateurs et constantes
typedef struct
{
   char name[20];
   char code[20];
   char type[20];
   int value;
   float val;
 } elt_idf_cst;

// la table des symboles des separateurs et mots clées
typedef struct
{  
   char name[20];
   char code[20];
} elt_sep_kw;

elt_idf_cst ts_idf_cst[1000];
elt_sep_kw ts_sep[40],ts_kw[40];

int cpt_idf_cst=0, cpt_kw=0, cpt_sep=0;

/***Step 2: initialisation de l'état des cases des tables des symbloles***/
/*0: la case est libre    1: la case est occupée*/

int search(char entity[], int t){
	int i=0;
	switch (t){
		case 0:
			while (i<cpt_idf_cst) {
				if (strcmp(entity,ts_idf_cst[i].name)==0) return i;
				i++;
			}
			return -1;
		
		case 1:
			while (i<cpt_sep) {
				if (strcmp(entity,ts_sep[i].name)==0) return i;
				i++;
			}
			return -1;
		case 2:
			while (i<cpt_kw) {
				if (strcmp(entity,ts_kw[i].name)==0) return i;
				i++;
			}
			return -1;
	
	}
}

// inserer dans le tableau une entité lexical
int insert(char entity[], char code[], char type[], int value, int t){
	switch (t){
		case 0:
			if (search(entity,0)==-1) {
				strcpy(ts_idf_cst[cpt_idf_cst].name,entity);
				strcpy(ts_idf_cst[cpt_idf_cst].code,code);
				strcpy(ts_idf_cst[cpt_idf_cst].type,type);
				ts_idf_cst[cpt_idf_cst].value= value;
				cpt_idf_cst++;
			}
			break;
		case 1:
			if (search(entity,1)==-1) {
				strcpy(ts_sep[cpt_sep].name,entity);
				strcpy(ts_sep[cpt_sep].code,code);
				cpt_sep++;
			}
			break;
		case 2:
			if (search(entity,2)==-1) {
				strcpy(ts_kw[cpt_kw].name,entity);
				strcpy(ts_kw[cpt_kw].code,code);
				cpt_kw++;
			}
			break;
	}
}

void print() {
    printf("\n\t _______________________________________________________________________\n");
    printf("\t|                             Table des IDF                             |\n");
    printf("\t|_______________________________________________________________________|\n");
    printf("\t| %-15s | %-15s | %-15s | %-15s |\n", "Name", "Code", "Type", "Value");
    printf("\t|_________________|_________________|_________________|_________________|\n");

    int i = 0;
    while (i < cpt_idf_cst) {
        printf("\t| %-15s | %-15s | %-15s | %-15d |\n", ts_idf_cst[i].name, ts_idf_cst[i].code, ts_idf_cst[i].type, ts_idf_cst[i].value);
        i++;
    }
    printf("\t|_________________|_________________|_________________|_________________|\n");

    printf("\n\t ___________________________________\n");
    printf("\t|           Table des mots cles     |\n");
    printf("\t|___________________________________|\n");
    printf("\t| %-15s | %-15s |\n", "Name", "Code");
    printf("\t|_________________|_________________|\n");

    i = 0;
    while (i < cpt_kw) {
        printf("\t| %-15s | %-15s |\n", ts_kw[i].name, ts_kw[i].code);
        i++;
    }
    printf("\t|_________________|_________________|\n");

    printf("\n\t ____________________\n");
    printf("\t|     Table des      |\n");
    printf("\t|    Separateurs     |\n");
    printf("\t|____________________|\n");
    printf("\t| %-5s | %-8s   |\n", "Name", "Code");
    printf("\t|_______|____________|\n");

    i = 0;
    while (i < cpt_sep) {
        printf("\t| %-5s | %-8s |\n", ts_sep[i].name, ts_sep[i].code);
        i++;
    }
    printf("\t|_______|____________|\n");
}

int insert_type(char entity[], char type[]){
	int pos=search(entity,0);//la recherche se fait dans la TS des IDF
	if (pos!=-1)
	{
		strcpy(ts_idf_cst[pos].type,type);
	}
}

int check_declaration(char entity[]){
	int pos=search(entity,0);
	if (pos!=-1 && strcmp(ts_idf_cst[pos].type,"")==0) 
		return 0;
	return -1;
}

