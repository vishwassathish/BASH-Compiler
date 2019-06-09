%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	
	#define COMMAND_LENGTH 4096
	#define PROGRAM_SIZE 40000

	void yyerror(const char*);
	extern char *yytext;
	extern FILE* fp;
	int yywrap(void){return 1;}
	extern int l;
	char* temp, text;

%}

%token IF ELSE ID NUM WHILE FOR CONTINUE BREAK RETURN FUNCTION SEQ ECHO LOCAL DO DONE THEN IN FI TERMINATOR MANDATORY END LT GT EQ LE GE NE AND OR INC DEC ELIF END_OF_FILE

%left '+' '-'
%left '*' '/'
%right '^'
%right '='
%left GE NE LT GT LE EQ
%left AND OR

%start PROGRAM

%%
PROGRAM				:	MANDATORY STATEMENT		{ printf("VALID PROGRAM\n"); char* prg = malloc(sizeof(char) * PROGRAM_SIZE); sprintf(prg, "{\"PROGRAM\" : [%s]}\n", strdup($2)); fp = fopen("AST.json", "w"); fprintf(fp,"%s", prg); fclose(fp); YYACCEPT; }
					;

STATEMENT			:	PRINT_STATEMENT STATEMENT {sprintf($$, "{\"STATEMENT\" : [%s, %s]}", strdup($1), $2); $$ = strdup($$);} 
					|	ASSIGNMENT_STATEMENT STATEMENT {sprintf($$, "{\"STATEMENT\" : [%s, %s]}", strdup($1), strdup($2));} 
					|	TERMINATOR STATEMENT  {sprintf($$, "{\"STATEMENT\" : [{\"terminator\" : \";\"}, %s]}", strdup($2));}
					|	IF_STATEMENT STATEMENT {sprintf($$, "{\"STATEMENT\" : [%s, %s]}", strdup($1), strdup($2));} 
					|	LOOPS STATEMENT {sprintf($$, "{\"STATEMENT\" : [%s, %s]}", strdup($1), strdup($2));} 
					|	END_OF_FILE {sprintf($$, "{\"END_OF_FILE\" : \"eof\"}");}
					|	{sprintf($$, "{\"EPSILON\" : \"eee\"}"); $$ = strdup($$);}
					;

PRINT_STATEMENT		:	ECHO E {sprintf($$, "{\"PRINT_STATEMENT\" : [{\"key\" : \"echo\"}, %s]}", strdup($2)); $$ = strdup($$); }
					|	ECHO ID {sprintf($$, "{\"PRINT_STATEMENT\" : [{\"key\" : \"echo\"}, %s]}", strdup($2)); $$ = strdup($$);}
					;

ASSIGNMENT_STATEMENT:	ID '=' E {sprintf($$, "{\"ASSIGNMENT_STATEMENT\" : [%s, {\"assign_operator\" :\"=\"}, %s]}", strdup($1), strdup($3));}
					;

IF_STATEMENT		:	IF '(' '(' CONDITION ')' ')' TERMINATOR THEN STATEMENT CONTINUE_IF {sprintf($$, "{\"IF\" : [{\"key\" : \"if\"}, %s, {\"key\" : \"then\"}, %s, %s]}", strdup($4), strdup($9), strdup($10));}
					; 

CONTINUE_IF			:	FI {sprintf($$, "{\"key\" : \"fi\"}");}
					|	ELSE STATEMENT FI {sprintf($$, "{\"ELSE\" : [%s, {\"key\" : \"fi\"}]}", strdup($2));}
					|	ELIF '(' '(' CONDITION ')' ')' TERMINATOR THEN STATEMENT CONTINUE_IF {sprintf($$, "{\"ELIF\" : [%s, {\"key\" : \"then\"}, %s, %s]}", strdup(4), strdup(9), strdup(10));}
					;

LOOPS				:	FOR_LOOP {sprintf($$, "{\"LOOPS\" : [%s]}", strdup($1));}
					|	WHILE_LOOP {sprintf($$, "{\"LOOPS\" : [%s]}", strdup($1));}
					;

FOR_LOOP			:	FOR ID IN '`' SEQ NUM NUM '`' TERMINATOR DO STATEMENT DONE {sprintf($$, "{\"FOR_LOOP\" : [{\"key\" :\"for\"}, {\"ID\" : \"%s\"}, {\"key\" : \"in\"}, {\"key\" : \"seq\"}, {\"NUM\" : \"%s\"}, {\"NUM\" : \"%s\"}, {\"key\" : \"do\"}, %s, {\"key\" : \"done\"}]}", strdup($2), strdup($6), strdup($7),strdup($11));}
					|	FOR ID IN '`' SEQ NUM NUM NUM '`' TERMINATOR DO STATEMENT DONE {sprintf($$, "{\"FOR_LOOP\" : [{\"key\" :\"for\"}, {\"ID\" : \"%s\"}, {\"key\" : \"in\"}, {\"key\" : \"seq\"}, {\"NUM\" : \"%s\"}, {\"NUM\" : \"%s\"}, {\"NUM\" : \"%s\"}, {\"key\" : \"do\"}, %s, {\"key\" : \"done\"}]}", strdup($2), strdup($6), strdup($7), strdup($8), strdup($12));}
					;

WHILE_LOOP			:	WHILE '(' '(' CONDITION ')' ')' TERMINATOR DO STATEMENT DONE {sprintf($$, "{\"WHILE_LOOP\" : [{\"key\" : \"while\"}, %s, {\"key\" : \"do\"}, %s, {\"key\" : \"done\"}]}", strdup($4), strdup($9));}
					;

CONDITION			:	 RELATIONAL_STATEMENT {$1 = strdup($1);} _CONDITION {sprintf($$, "{\"CONDITION\" : [%s, %s]}", strdup($1), $3);}
					;

_CONDITION			:	_LOGICALOP CONDITION {sprintf($$, "{\"_CONDITION\" : [%s, %s]}", strdup($1), strdup($2));}
					|	{sprintf($$, "{\"EPSILON\" : \"eps\"}");}
					;

_LOGICALOP			:	'&''&' {sprintf($$, "{\"LOGICAL\" : \"&&\"}");}
					|	'|''|' {sprintf($$, "{\"LOGICAL\" : \"||\"}");}
					;

RELATIONAL_STATEMENT:	E _RELOP E {sprintf($$, "{\"RELATIONAL_STATEMENT\" : [%s, %s, %s]}", strdup($1), strdup($2), strdup($3));}
					|	E {sprintf($$, "{\"RELATIONAL_STATEMENT\" : [%s]}", strdup($1));}
					;

_RELOP				:	'<' {sprintf($$, "{\"RELOP\" : \"<\"}");}
					|	'>' {sprintf($$, "{\"RELOP\" : \">\"}");}
					|	'<' '=' {sprintf($$, "{\"RELOP\" : \"<=\"}");}
					|	'>' '=' {sprintf($$, "{\"RELOP\" : \">=\"}");}
					|	'!' '=' {sprintf($$, "{\"RELOP\" : \"!=\"}");}
					|	'=' '=' {sprintf($$, "{\"RELOP\" : \"==\"}");}
					;

E					:	E '+' T {sprintf($$, "{\"E\" : [%s, {\"arithmetic_op\" :\"+\"}, %s]}", strdup($1), strdup($3));}
					|	E '-' T {sprintf($$, "{\"E\" : [%s, {\"arithmetic_op\" :\"-\"}, %s]}", strdup($1), strdup($3));}
					|	T {sprintf($$, "{\"E\" : [%s]}", strdup($1));}
					;

T					:	T '*' F {sprintf($$, "{\"T\" : [%s, {\"arithmetic_op\" :\"*\"}, %s]}", strdup($1), strdup($3));}
					|	T '/' F {sprintf($$, "{\"T\" : [%s, {\"arithmetic_op\" : \"/\"}, %s]}", strdup($1), strdup($3));}
					|	F {sprintf($$, "{\"T\" : [%s]}", strdup($1));}
					;

F					:	F '^' G {sprintf($$, "{\"F\": [%s, {\"arithmetic_op\" :\"^\"}, %s]}", strdup($1), strdup($3));}
					|	G  {sprintf($$, "{\"F\" : [%s]}", strdup($1));}
					;

G					:	'$' ID {char* text = malloc(sizeof(char)*50); sprintf(text, "{\"G\" : \"%s\"}", yylval); $$ = text; }
					|	'$' NUM {char* text = malloc(sizeof(char)*50); sprintf(text, "{\"G\" : \"%s\"}", yylval);$$ = text;}
					|	NUM 	{char* text = malloc(sizeof(char)*50); sprintf(text, "{\"G\" : \"%s\"}", yylval); $$ = text;}
					|	'$' '(''(' E ')'')'  {sprintf($$, "{\"G\" : [%s]}", $4); /* Some bad Printing*/}
 					;
%%


void yyerror(const char* s)
{
	printf("%s\n",s);
	printf("Error at Line %d\n", l);
	exit(0);
}
