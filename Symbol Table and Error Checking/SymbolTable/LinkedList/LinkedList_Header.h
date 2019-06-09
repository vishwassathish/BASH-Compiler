#ifndef _STDLIB_H
	#include <stdlib.h>
#endif

#ifndef _SETJMP_H
	#include <setjmp.h>
#endif

#ifndef OPERATION_FAILED
	#define OPERATION_FAILED 0
#endif

#ifndef OPERATION_SUCCESSFUL
	#define OPERATION_SUCCESSFUL 1
#endif

typedef void* LinkedListElementType;

typedef struct linked_list_node
{
	LinkedListElementType data;
	struct linked_list_node* nextNode;
} LinkedListNodeStructure;

typedef LinkedListNodeStructure* LinkedListNode;

typedef struct linked_list_structure
{
	LinkedListNode head;
	int size;
} LinkedListStructure;

typedef LinkedListStructure* LinkedList;

jmp_buf jump;

LinkedList LinkedList_Create();
int LinkedList_Size(LinkedList linkedList);
int LinkedList_AddToPosition(LinkedList linkedList, LinkedListElementType element, int position);
int LinkedList_AddToFirst(LinkedList linkedList, LinkedListElementType data);
int LinkedList_AddToLast(LinkedList linkedList, LinkedListElementType data);
int LinkedList_DeleteFromPosition(LinkedList linkedList, int position);
int LinkedList_DeleteFromFirst(LinkedList linkedList);
int LinkedList_DeleteFromLast(LinkedList linkedList);
int LinkedList_Traverse(LinkedList linkedList, void (*Function)(LinkedListElementType, int));
LinkedListElementType LinkedList_GetFromPosition(LinkedList linkedList, int position);

#include "LinkedList_Implementation.c"