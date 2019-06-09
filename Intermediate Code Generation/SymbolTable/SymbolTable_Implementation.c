SymbolTable SymbolTable_Create()
{
	SymbolTable s = (SymbolTable) malloc (sizeof(SymbolTableStructure));
	s->rows = LinkedList_Create();

	return s;
}

void SymbolTable_Insert(SymbolTable s, char* type, char* value)
{
	int i = -1;

	void Traverse(void* data, int end)
	{
		static int _i = 0;

		SymbolTableRow row = (SymbolTableRow) data;

		if (!strcmp(row->type, type) == 0)
		{
			_i++;
		}
		else
		{
			i = _i;
			_i = 0;

			longjmp(jump, 1);
		}

		if (end)
		{
			_i = 0;
		}
	}

	LinkedList_Traverse(s->rows, Traverse);

	if (i == -1)
	{
		SymbolTableRow row = (SymbolTableRow) malloc (sizeof(SymbolTableRowStructure));
		row->listOfValues = LinkedList_Create();

		strcpy(row->type, type);
		LinkedList_AddToLast(s->rows, (void*) row);

		i = LinkedList_Size(s->rows) - 1;
	}

	LinkedList_AddToLast(((SymbolTableRow) LinkedList_GetFromPosition(s->rows, i))->listOfValues, (void*) value);



	return;
}

char* TypeOfToken(SymbolTable s, char *token)
{
	int i = 0;
	for(i = 0 ; i < LinkedList_Size(s->rows) ; i++)
	{
		SymbolTableRow row = LinkedList_GetFromPosition(s->rows, i);

		int j = 0;
		for (; j < LinkedList_Size(row->listOfValues); j++)
		{
			char* value = LinkedList_GetFromPosition(row->listOfValues, j);
			if (strcmp(token, value) == 0)
			{
				return row->type;
			}
		}
	}

	return NULL;
}

void PrintSymbolTable(SymbolTable s)
{
	void Traverse1(void* data, int end)
	{
		SymbolTableRow row = (SymbolTableRow) data;
		printf("%s\n", row->type);

		void Traverse2(void* data, int end)
		{
			printf("\t%s\n", (char*) data);
		}

		LinkedList_Traverse(row->listOfValues, Traverse2);
	}

	LinkedList_Traverse(s->rows, Traverse1);
}