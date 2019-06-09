%{
	#include "y.tab.h"

	#include "SymbolTable/SymbolTable_Header.h"

	void yyerror(const char*);

	SymbolTable symbolTable;
	extern int line_number;
	
%}
letter		[_a-zA-Z]
symbols		["$" | "(" | ")" | "{" | "}" | "," | "&" | "\"" | "|" | "<" | ">" | "=" | "!" | "+" | "-" | "*" | "/" | "`" | "^"]
digit		[0-9]
id			{letter}({letter}|{digit})*
number		({digit})+
%%
"#!/bin/bash"						{ symbolTable = SymbolTable_Create(); return MANDATORY; }
"#!/bin/sh"							{ symbolTable = SymbolTable_Create(); return MANDATORY; }
"#".*								;
" "									;
"while"								{ char* string = (char*) malloc (sizeof(char) * 6); sprintf(string, "while %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return WHILE; }
"for"								{ char* string = (char*) malloc (sizeof(char) * 4); sprintf(string, "for %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return FOR; }
"if"								{ char* string = (char*) malloc (sizeof(char) * 3); sprintf(string, "if %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return IF; }
"fi"								{ char* string = (char*) malloc (sizeof(char) * 3); sprintf(string, "fi %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return FI; }
"else"								{ char* string = (char*) malloc (sizeof(char) * 5); sprintf(string, "else %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return ELSE; }
"else if"							{ char* string = (char*) malloc (sizeof(char) * 5); sprintf(string, "elif %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return ELIF; }
"then"								{ char* string = (char*) malloc (sizeof(char) * 5); sprintf(string, "then %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return THEN; }
"seq"								{ char* string = (char*) malloc (sizeof(char) * 4); sprintf(string, "seq %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return SEQ; }
"break"								{ char* string = (char*) malloc (sizeof(char) * 6); sprintf(string, "break %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return BREAK; }
"return"							{ char* string = (char*) malloc (sizeof(char) * 7); sprintf(string, "return %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return RETURN; }
"in"								{ char* string = (char*) malloc (sizeof(char) * 3); sprintf(string, "in %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return IN; }
"do"								{ char* string = (char*) malloc (sizeof(char) * 3); sprintf(string, "do %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return DO; }
"done"								{ char* string = (char*) malloc (sizeof(char) * 5); sprintf(string, "done %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return DONE; }
"function"							{ char* string = (char*) malloc (sizeof(char) * 9); sprintf(string, "function %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return FUNCTION; }
"echo"								{ char* string = (char*) malloc (sizeof(char) * 5); sprintf(string, "echo %d", yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return ECHO; }
"local"								{ char* string = (char*) malloc (sizeof(char) * 6); sprintf(string, "local %d",yylineno); SymbolTable_Insert(symbolTable, "KEYWORD", string); return LOCAL; }
"++"								{ char* string = (char*) malloc (sizeof(char) * 2); sprintf(string, "++ %d",yylineno); SymbolTable_Insert(symbolTable, "OPERATOR", string); return INC; }
"--"								{ char* string = (char*) malloc (sizeof(char) * 2); sprintf(string, "-- %d", yylineno); SymbolTable_Insert(symbolTable, "OPERATOR", string); return DEC; }
"=="								{ char* string = (char*) malloc (sizeof(char) * 2); sprintf(string, "== %d", yylineno); SymbolTable_Insert(symbolTable, "OPERATOR", string); return EQ; }
<<EOF>>								return END_OF_FILE; 
{id}								{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); sprintf(string, "%s %d" ,yytext, yylineno); SymbolTable_Insert(symbolTable, "ID", string); return ID; }
{number}							{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); sprintf(string, "%s %d", yytext, yylineno); SymbolTable_Insert(symbolTable, "NUM", string); return NUM; }
{symbols}							{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); sprintf(string, "%s %d", yytext, yylineno); SymbolTable_Insert(symbolTable, "SYMBOL", string); return *yytext; }
";"									{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); sprintf(string, "%s %d", yytext, yylineno); SymbolTable_Insert(symbolTable, "TERMINATOR", string); return TERMINATOR; }
\n									{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); sprintf(string, "\\n %d", yylineno); SymbolTable_Insert(symbolTable, "TERMINATOR", string); line_number++; yylineno++;  return TERMINATOR; }
.									;
%%

int main()
{
//	yyin = fopen("input.sh", "r");

	yyparse();

	PrintSymbolTable(symbolTable);

	return 0;
}
