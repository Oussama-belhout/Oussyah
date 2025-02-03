%{
#include <stdio.h>
int yylex(void);
int yyerror(char* msg);
int yywrap ();
int nb_line=1;
int col=1;
char save_type[20];
%}

%union{
    int integer;
	float real;
    char* str;
}

%token <str>id <integer>cst <integer>int_val <real>real_val <str>str_val bool_val
%token program end routine endr si then sinon endif dowhile enddo equivalence 
%token read write call sc cm gparen dparen plus minus mult divis egale
%token <str>integer <str>character <str>real <str>logical dimension
%token dp eq ou et gt ge ne le lt

%%

PROGRAM_P: program id LIST_DEC LIST_INST end {
	printf("Programme principal est correcte syntaxiquement\n");
    //YYACCEPT;
	} 
;
LIST_DEC: DEC LIST_DEC
	|
;
DEC: TYPE LIST_IDF sc 
   | TYPE DEC_CHAR sc
;
DEC_CHAR: id mult cst cm  DEC_CHAR{
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);} 
        | id mult cst cm  LIST_IDF{
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);}
		| id mult cst{
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);}
		
;
LIST_IDF: id cm LIST_IDF {
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);}
    | TAB cm LIST_IDF 
	| TAB 
	| id {
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);}
;
TAB: id dimension gparen cst dparen {
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);
    }
   | id dimension gparen cst cm cst dparen {
	if(check_declaration($1)==0)
		insert_type($1,save_type);
	else
		printf("erreur semantique, double declaration de l'idf : %s a la ligne %d\n",$1,nb_line);
    }
;
TYPE: integer {strcpy(save_type,$1);}
    | character {strcpy(save_type,$1);}
	| real {strcpy(save_type,$1);}
	| logical {strcpy(save_type,$1);}
;
LIST_INST: INST LIST_INST
	|
;
INST: INST_AFF sc
    | READ sc
    | WRITE sc
    | CONDITIONAL
    | LOOP
    | EQUIVALENCE sc
;
INST_AFF: ID egale E //E=EXPRESSION
        | ID egale CALL_FUNCTION
;
E: E1
;
E1: E1 plus E2| E1 minus E2 | E2
;
E2: E2 mult E3 | E2 divis E3 | E3
;
E3: gparen E dparen {printf("On a ouvrit et fermé un parenthese \n");} | VAR 
;
VAR: int_val | real_val | str_val | BOOL | cst //| gparen VAR dparen
;
BOOL: bool_val | ID 
;
ID: id {if(check_declaration($1)==0)printf("erreur semantique idf %s non declaree at line %d \n",$1,nb_line);}
  | TAB_ID
;
TAB_ID: id gparen E dparen {if(check_declaration($1)==0)printf("erreur semantique idf %s non declaree at line %d \n",$1,nb_line);}
	  | id gparen E cm E dparen {if(check_declaration($1)==0)printf("erreur semantique idf %s non declaree at line %d \n",$1,nb_line);}
;
CALL_FUNCTION: call id gparen ARGUMENT_LIST dparen
;
ARGUMENT_LIST: E cm ARGUMENT_LIST | E |
;

READ: read gparen ID dparen {printf("la valeur est lu\n");}
;
WRITE: write gparen str_val cm ID_LIST 
     | write gparen str_val dparen
;
ID_LIST: ID cm ID_LIST 
       | ID END_LIST 
;
END_LIST: cm str_val dparen 
        | dparen
;

CONDITIONAL: DEB_COND sinon LIST_INST endif {printf("Structure conditionnelle correcte\n"); }
           | DEB_COND endif {printf("Structure conditionnelle correcte\n"); }
;
DEB_COND: DEB_IF then LIST_INST 
;
DEB_IF: si gparen CONDITION dparen 
;
LOOP: dowhile gparen CONDITION dparen LIST_INST enddo {
    printf("Boucle correcte\n");
}
;

CONDITION: CONDITION eq CONDITION1 | CONDITION1
    | CONDITION ne CONDITION1
    | CONDITION gt CONDITION1
    | CONDITION ge CONDITION1
    | CONDITION le CONDITION1
	| CONDITION lt CONDITION1
;
CONDITION1: CONDITION1 ou CONDITION2 | CONDITION2
    | CONDITION1 et CONDITION2
;
CONDITION2: gparen BOOL dparen | gparen CONDITION dparen 
;


/*
CONDITION3: 
;

CONDITION: C1 //C=CONDITION
;
C1: C1 et C2 | C1 ou C2 | C1 eq C2 | C1 ne C2 | C1 gt C2 | C1 ge C2 | C1 le C2 | C1 lt C2 | C2
;
C2: C2 plus C3 | C2 minus C3 | C3
;
C3: C3 mult C4 | C3 divis C4 | C4
;
C4: gparen C1 dparen | VAR | ID
;
*/
EQUIVALENCE: equivalence EQUIV
;
EQUIV: gparen VAR_LIST dparen cm EQUIV 
     | gparen VAR_LIST dparen
;
VAR_LIST: ID cm VAR_LIST
	 | ID 
;

%% main()
{
yyparse();
print();
}
yywrap()
{}
int yyerror(char *msg) 
{ printf("%s a la ligne %d colonne %d", msg, nb_line, col);
  return 1;
}