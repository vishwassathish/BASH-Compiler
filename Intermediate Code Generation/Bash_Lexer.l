%{
	#include "y.tab.h"

	#include "SymbolTable/SymbolTable_Header.h"

	void yyerror(const char*);

	extern YYSTYPE yylval;

	SymbolTable symbolTable;
	
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
"\".*\""							{ char* string = (char*) malloc (sizeof(char) * yyleng); strcpy(string, yytext); yylval = string; SymbolTable_Insert(symbolTable, "STRING", string); printf("1: %s\n", string); return STRING;}
"while"								{ char* string = (char*) malloc (sizeof(char) * 6); strcpy(string, "while"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return WHILE; }
"for"								{ char* string = (char*) malloc (sizeof(char) * 4); strcpy(string, "for"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return FOR; }
"if"								{ char* string = (char*) malloc (sizeof(char) * 3); strcpy(string, "if"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return IF; }
"fi"								{ char* string = (char*) malloc (sizeof(char) * 3); strcpy(string, "fi"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return FI; }
"else"								{ char* string = (char*) malloc (sizeof(char) * 5); strcpy(string, "else"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return ELSE; }
"else if"							{ char* string = (char*) malloc (sizeof(char) * 5); strcpy(string, "elif"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return ELIF; }
"then"								{ char* string = (char*) malloc (sizeof(char) * 5); strcpy(string, "then"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return THEN; }
"seq"								{ char* string = (char*) malloc (sizeof(char) * 4); strcpy(string, "seq"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return SEQ; }
"break"								{ char* string = (char*) malloc (sizeof(char) * 6); strcpy(string, "break"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return BREAK; }
"return"							{ char* string = (char*) malloc (sizeof(char) * 7); strcpy(string, "return"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return RETURN; }
"in"								{ char* string = (char*) malloc (sizeof(char) * 3); strcpy(string, "in"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return IN; }
"do"								{ char* string = (char*) malloc (sizeof(char) * 3); strcpy(string, "do"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return DO; }
"done"								{ char* string = (char*) malloc (sizeof(char) * 5); strcpy(string, "done"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return DONE; }
"function"							{ char* string = (char*) malloc (sizeof(char) * 9); strcpy(string, "function"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return FUNCTION; }
"echo"								{ char* string = (char*) malloc (sizeof(char) * 5); strcpy(string, "echo"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return ECHO; }
"local"								{ char* string = (char*) malloc (sizeof(char) * 6); strcpy(string, "local"); yylval = string; SymbolTable_Insert(symbolTable, "KEYWORD", string); return LOCAL; }
"++"								{ char* string = (char*) malloc (sizeof(char) * 2); strcpy(string, "++"); yylval = string; SymbolTable_Insert(symbolTable, "OPERATOR", string); return INC; }
"--"								{ char* string = (char*) malloc (sizeof(char) * 2); strcpy(string, "--"); yylval = string; SymbolTable_Insert(symbolTable, "OPERATOR", string); return DEC; }
"=="								{ char* string = (char*) malloc (sizeof(char) * 2); strcpy(string, "=="); yylval = string; SymbolTable_Insert(symbolTable, "OPERATOR", string); return EQ; }
<<EOF>>								return END_OF_FILE; 
{id}								{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); strcpy(string, yytext); yylval = string; SymbolTable_Insert(symbolTable, "ID", string); return ID; }
{number}							{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); strcpy(string, yytext); yylval = string; SymbolTable_Insert(symbolTable, "NUM", string); return NUM; }
{symbols}							{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); strcpy(string, yytext); yylval = string; SymbolTable_Insert(symbolTable, "SYMBOL", string); return *yytext; }
";"									{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); strcpy(string, yytext); yylval = string; SymbolTable_Insert(symbolTable, "TERMINATOR", string); return TERMINATOR; }
\n									{ char* string = (char*) malloc (sizeof(char) * (strlen(yytext)+1)); strcpy(string, yytext); yylval = string; SymbolTable_Insert(symbolTable, "TERMINATOR", string);  return TERMINATOR; }
.									;
%%

int main()
{
	yyparse();

	return 0;
}
