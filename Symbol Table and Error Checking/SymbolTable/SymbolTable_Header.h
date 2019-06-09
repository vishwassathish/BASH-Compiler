#ifndef _STDLIB_H
	#include <stdlib.h>
#endif

#include "LinkedList/LinkedList_Header.h"

extern jmp_buf jump;

typedef struct SymbolTableRowEntry
{
	char type[100];
	LinkedList listOfValues;
} SymbolTableRowStructure;

typedef SymbolTableRowStructure* SymbolTableRow;

typedef struct  _SymbolTable 
{ 
	LinkedList rows;
} SymbolTableStructure;

typedef	SymbolTableStructure* SymbolTable;

SymbolTable SymbolTable_Create();
void SymbolTable_Insert(SymbolTable s, char* type, char* value);
char* TypeOfToken(SymbolTable s, char *token);
void PrintSymbolTable(SymbolTable s);

#include "SymbolTable_Implementation.c"