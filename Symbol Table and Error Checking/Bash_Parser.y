%{
	#include <stdio.h>
	#include <stdlib.h>

	#define YYSTYPE char*

	void yyerror(const char*);

	int yywrap(void){return 1;}
	int yylex();

	int line_number = 0;
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

PRINT_STATEMENT		:	ECHO  '$' '(' '(' E ')' ')'
					|	ECHO STRING
					;

ASSIGNMENT_STATEMENT:	ID '=' E
					;

IF_STATEMENT		:	IF '(' '(' CONDITION ')' ')' TERMINATOR THEN STATEMENT CONTINUE_IF
					; 

CONTINUE_IF			:	FI
					|	ELSE STATEMENT FI
					|	ELIF '(' '(' CONDITION ')' ')' TERMINATOR THEN STATEMENT CONTINUE_IF

LOOPS				:	FOR_LOOP
					|	WHILE_LOOP
					;

FOR_LOOP			:	FOR ID IN '`' SEQ NUM NUM '`' TERMINATOR DO STATEMENT DONE
					| 	FOR ID IN '`' SEQ NUM NUM NUM '`' TERMINATOR DO STATEMENT DONE
					;

WHILE_LOOP			:	WHILE '(' '(' CONDITION ')' ')' TERMINATOR DO STATEMENT DONE
					;

FUNCTION_STATEMENT	:	FUNCTION ID '{'	STATEMENT '}' TERMINATOR
					|	ID '(' ')' '{' STATEMENT '}' TERMINATOR
					|	FUNCTION ID '(' ')' '{' STATEMENT '}' TERMINATOR
					;

CONDITION			:	 RELATIONAL_STATEMENT _CONDITION
					;

_CONDITION			:	_LOGICALOP CONDITION
					|
					;

_LOGICALOP			:	'&''&'
					|	'|''|'
					;

RELATIONAL_STATEMENT:	'$' '(' '(' E _RELOP E ')' ')'
					|	E 
					;


_RELOP				:	'<'
					|	'>'
					|	'<' '='
					|	'>' '='
					|	'!' '='
					|	'=' '='
					;

E					:	E '+' T
					|	E '-' T
					|	T
					;

T					:	T '*' F
					|	T '/' F
					|	F
					;

F					:	F '^' G
					|	G
					;

G					:	'$' ID
					|	'$' NUM
					|	NUM
					|	'$' '(' '(' E ')' ')'
					;
%%

void yyerror(const char* s)
{
	printf("Error at line number %d\n%s\n", line_number+1, s);
	exit(1);
}
