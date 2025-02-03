#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure pour représenter une entité (identificateurs/constantes, séparateurs, mots-clés)
typedef struct Entity {
    char name[20];
    char code[20];
    char type[20];
    int value;
    float val;
    struct Entity *next; // Pointeur vers l'entité suivante dans la liste
} Entity;

// Liste chaînée pour stocker les entités de chaque type
typedef struct SymbolTable {
    Entity *head;
} SymbolTable;

SymbolTable ts_idf_cst, ts_sep, ts_kw;

// Initialisation des tables des symboles
void initSymbolTable(int t) {
    switch (t) {
        case 0:
            ts_idf_cst.head = NULL;
            break;
        case 1:
            ts_sep.head = NULL;
            break;
        case 2:
            ts_kw.head = NULL;
            break;
        default:
            // Gérer une erreur, indice de table non valide
            break;
    }
}

// Recherche d'une entité dans la table des symboles
Entity *search(int t, char entity[]) {
    Entity *current;
    switch (t) {
        case 0:
            current = ts_idf_cst.head;
            break;
        case 1:
            current = ts_sep.head;
            break;
        case 2:
            current = ts_kw.head;
            break;
        default:
            // Gérer une erreur, indice de table non valide
            return NULL;
    }

    while (current != NULL) {
        if (strcmp(current->name, entity) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

// Insertion d'une entité dans la table des symboles
int insert(char entity[], char code[], char type[], int value, int t){
    Entity *current;
    switch (t) {
        case 0:
            current = ts_idf_cst.head;
            break;
        case 1:
            current = ts_sep.head;
            break;
        case 2:
            current = ts_kw.head;
            break;
        default:
            // Gérer une erreur, indice de table non valide
            return;
    }

    while (current != NULL) {
        if (strcmp(current->name, entity) == 0) {
            return; // L'entité existe déjà, ne rien faire
        }
        current = current->next;
    }

    Entity *newEntity = (Entity *)malloc(sizeof(Entity));
    strcpy(newEntity->name, entity);
    strcpy(newEntity->code, code);
    strcpy(newEntity->type, type);
    newEntity->value = value;
    newEntity->next = NULL;

    switch (t) {
        case 0:
            newEntity->next = ts_idf_cst.head;
            ts_idf_cst.head = newEntity;
            break;
        case 1:
            newEntity->next = ts_sep.head;
            ts_sep.head = newEntity;
            break;
        case 2:
            newEntity->next = ts_kw.head;
            ts_kw.head = newEntity;
            break;
        default:
            // Gérer une erreur, indice de table non valide
            free(newEntity);
            break;
    }
}

// Affichage de la table des symboles
void print(int t) {

    Entity *current;
    char *tableType;
    switch (t) {
        case 0:
            current = ts_idf_cst.head;
            tableType = "IDENTIFICATEURS";
            break;
        case 1:
            current = ts_sep.head;
            tableType = "SEPARATEURS";
            break;
        case 2:
            current = ts_kw.head;
            tableType = "MOTS CLEES";
            break;
        default:
            // Gérer une erreur, indice de table non valide
            return;
    }
    printf("\n\t __________________________________________\n");
    printf("\t|             Table des %s                |\n", tableType);
    printf("\t|__________________________________________|\n");
    printf("\t| %-15s | %-15s | %-15s | %-15s |\n", "Name", "Code", "Type", "Value");
    printf("\t|_________________|_________________|_________________|_________________|\n");


    while (current != NULL) {
        printf("\t| %-15s | %-15s | %-15s | %-15d |\n", current->name, current->code, current->type, current->value);
        current = current->next;
    }

    printf("\t|_________________|_________________|_________________|_________________|\n");
}

// Fonction pour insérer le type dans la table des symboles des identificateurs/constantes
void insertType(int t, char entity[], char type[]) {
    Entity *entityNode = search(t, entity);
    if (entityNode != NULL) {
        strcpy(entityNode->type, type);
    }
}

// Fonction pour vérifier la déclaration d'une entité dans la table des symboles des identificateurs/constantes
int checkDeclaration(int t, char entity[]) {
    Entity *entityNode = search(t, entity);
    return (entityNode != NULL && strcmp(entityNode->type, "") == 0) ? 0 : -1;
}

// Fonction pour insérer une entité en utilisant l'indice t pour sélectionner la table
void insertByType(char entity[], char code[], char type[], int value, int t) {
    switch (t) {
        case 0:
            insert(entity, code, type, value ,t);
            break;
        case 1:
            insert(entity, code, "", 0 , t);
            break;
        case 2:
            insert(entity, code, "", 0 , t);
            break;
        default:
            // Gérer une erreur, indice de table non valide
            break;
    }
}

int insert_type(char entity[], char type[]) {
    Entity* foundEntity = search(0, entity); // Search in the symbol table of IDF
    if (foundEntity != NULL) {
        // Assuming Entity has a 'type' field
        strcpy(foundEntity->type, type);
        // Optionally, you might want to perform additional actions
        // after updating the type.
        return 0; // Successful insertion
    }
    return -1; // Entity not found in the symbol table
}

int check_declaration(char entity[]) {
    Entity* foundEntity = search(0, entity);
    if (foundEntity != NULL && foundEntity->type[0] == '\0') {
        return 0; // Declaration found and type is empty
    }
    return -1; // Not found or already declared
}

