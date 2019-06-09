%{
	#include <stdio.h>
	#include <stdlib.h>

	#define YYSTYPE char*

	void yyerror(const char*);

	int yywrap(void){return 1;}
	int yylex();

	char* _Generate_New_Label()
	{
		static int i = 0;

		char* newLabel = (char*) malloc (sizeof(10));
		sprintf(newLabel, "L%d", i++);

		return newLabel;
	}

	char* _Generate_New_Temporary()
	{
		static int i = 0;

		char* newTemp = (char*) malloc (sizeof(10));
		sprintf(newTemp, "t%d", i++);

		return newTemp;
	}

%}

%token IF ELSE ID NUM WHILE FOR CONTINUE BREAK RETURN FUNCTION SEQ ECHO LOCAL DO DONE THEN IN FI TERMINATOR MANDATORY END LT GT EQ LE GE NE AND OR INC DEC ELIF END_OF_FILE STRING

%left '+' '-'
%left '*' '/'
%right '^'
%right '='
%left GE NE LT GT LE EQ
%left AND OR

%start PROGRAM

%%

PROGRAM				:	MANDATORY STATEMENT {YYACCEPT;}
					;

STATEMENT			:	PRINT_STATEMENT STATEMENT  			
					|	ASSIGNMENT_STATEMENT STATEMENT
					|	RELATIONAL_STATEMENT STATEMENT
					|	TERMINATOR STATEMENT
					|	IF_STATEMENT STATEMENT 
					|	LOOPS STATEMENT 
					|	FUNCTION_STATEMENT STATEMENT
					|	END_OF_FILE
					|
					;

PRINT_STATEMENT		:	ECHO  '$' '(' '(' E ')' ')' {printf("print %s\n", $5);}
					|	ECHO STRING {printf("print %s\n", $2);}
					;

ASSIGNMENT_STATEMENT:	ID '=' E {printf("%s = %s\n", $1, $3);}
					;

IF_STATEMENT		:	IF '(' '(' CONDITION {char* newLabel = _Generate_New_Label(); printf("ifFalse %s goto %s\n", $4, newLabel); $1 = newLabel;} ')' ')' TERMINATOR THEN STATEMENT {char* newLabel = _Generate_New_Label(); printf("goto %s\n", newLabel); printf("%s:\n", $1); $$ = newLabel;} CONTINUE_IF {printf("%s:\n", $11);}
					; 

CONTINUE_IF			:	FI {$$ = _Generate_New_Label();}
					|	ELSE STATEMENT FI {$$ = _Generate_New_Label();}
					|	ELIF '(' '(' CONDITION {char* newLabel = _Generate_New_Label(); printf("ifFalse %s goto %s\n", $4, newLabel); $1 = newLabel;} ')' ')' TERMINATOR THEN STATEMENT {char* newLabel = _Generate_New_Label(); printf("goto %s\n", newLabel); printf("%s:\n", $1); $$ = newLabel;} CONTINUE_IF {printf("%s:\n", $11);}

LOOPS				:	FOR_LOOP
					|	WHILE_LOOP
					;

FOR_LOOP			:	FOR ID IN '`' SEQ NUM NUM '`' {printf("%s = %s\n", $2, $6); char* newLabel1 = _Generate_New_Label(); char* newLabel2 = _Generate_New_Label(); char* newTemp = _Generate_New_Temporary(); $1 = newLabel1; printf("%s:\n%s = %s <= %s\nifFalse %s goto %s\n", newLabel1, newTemp, $2, $7, newTemp, newLabel2); $3 = newLabel2;} TERMINATOR DO STATEMENT DONE {char* newTemp = _Generate_New_Temporary(); printf("%s = %s + 1\n%s = %s\ngoto %s\n%s:\n", newTemp, $2, $2, newTemp, $1, $3);}
					| 	FOR ID IN '`' SEQ NUM NUM NUM '`' {printf("%s = %s\n", $2, $6); char* newLabel1 = _Generate_New_Label(); char* newLabel2 = _Generate_New_Label(); char* newTemp = _Generate_New_Temporary(); $1 = newLabel1; printf("%s:\n%s = %s <= %s\nifFalse %s goto %s\n", newLabel1, newTemp, $2, $8, newTemp, newLabel2); $3 = newLabel2;} TERMINATOR DO STATEMENT DONE {char* newTemp = _Generate_New_Temporary(); printf("%s = %s + %s\n%s = %s\ngoto %s\n%s:\n", newTemp, $2, $7, $2, newTemp, $1, $3);}
					;

WHILE_LOOP			:	WHILE {char* newLabel1 = _Generate_New_Label(); $1 = newLabel1; printf("%s:\n", newLabel1); } '(' '(' CONDITION {char* newLabel = _Generate_New_Label(); printf("ifFalse %s goto %s\n", $5, newLabel); $3 = newLabel;} ')' ')' TERMINATOR DO STATEMENT DONE {printf("goto %s\n%s:\n", $1, $3);}
					;

FUNCTION_STATEMENT	:	FUNCTION ID '{'	STATEMENT '}' TERMINATOR
					|	ID '(' ')' '{' STATEMENT '}' TERMINATOR
					|	FUNCTION ID '(' ')' '{' STATEMENT '}' TERMINATOR
					;

CONDITION			:	 RELATIONAL_STATEMENT _CONDITION {char* _text = (char*) malloc (sizeof(char) * (strlen($2) + 4)); char* newTemp = _Generate_New_Temporary(); printf("%s = %s %s\n", newTemp, $1, $2); $$ = newTemp;}
					;

_CONDITION			:	_LOGICALOP CONDITION {char* _text = (char*) malloc (sizeof(char) * (strlen($2) + 4)); sprintf(_text, "%s %s", $1, $2); $$ = _text;}
					|	{$$ = strdup("");}
					;

_LOGICALOP			:	'&''&' {char* _text = strdup("&&"); $$ = _text;}
					|	'|''|' {char* _text = strdup("||"); $$ = _text;}
					;

RELATIONAL_STATEMENT:	'$' '(' '(' E _RELOP E ')' ')' {char* newTemp = _Generate_New_Temporary(); printf("%s = %s %s %s\n", newTemp, $4, $5, $6); $$ = newTemp;}
					|	E {char* newTemp = _Generate_New_Temporary(); printf("%s = %s\n", newTemp, $1); $$ = newTemp;}
					;


_RELOP				:	'<' {char* _text = strdup("<"); $$ = _text;}
					|	'>'	{char* _text = strdup(">"); $$ = _text;}
					|	'<' '=' {char* _text = strdup("<="); $$ = _text;}
					|	'>' '=' {char* _text = strdup(">="); $$ = _text;}
					|	'!' '=' {char* _text = strdup("!="); $$ = _text;}
					|	'=' '=' {char* _text = strdup("=="); $$ = _text;}
					;

E					:	E '+' T {char* newTemp = _Generate_New_Temporary(); printf("%s = %s + %s\n", newTemp, $1, $3); $$ = newTemp;}
					|	E '-' T {char* newTemp = _Generate_New_Temporary(); printf("%s = %s - %s\n", newTemp, $1, $3); $$ = newTemp;}
					|	T {$$ = $1;}
					;

T					:	T '*' F {char* newTemp = _Generate_New_Temporary(); printf("%s = %s * %s\n", newTemp, $1, $3); $$ = newTemp;}
					|	T '/' F {char* newTemp = _Generate_New_Temporary(); printf("%s = %s / %s\n", newTemp, $1, $3); $$ = newTemp;}
					|	F {$$ = $1;}
					;

F					:	F '^' G {char* newTemp = _Generate_New_Temporary(); printf("%s = %s ^ %s\n", newTemp, $1, $3); $$ = newTemp;}
					|	G {$$ = $1;}
					;

G					:	'$' ID  {char* _text = yylval; $$ = _text;}
					|	'$' NUM {char* _text = yylval; $$ = _text;}
					|	NUM {char* _text = yylval; $$ = _text;}
					|	'$' '(' '(' E ')' ')' {$$ = $4;}
					;
%%

void yyerror(const char* s)
{
	printf("%s\n",s);
	exit(0);
}
