%{
	#include "y.tab.h"

	void yyerror(const char*);
	extern YYSTYPE yylval ;
	FILE* fp;
	int l = 0;
	
%}
%option 	yylineno
letter		[_a-zA-Z]
symbols		["$" | "(" | ")" | "{" | "}" | "," | "&" | "\"" | "|" | "<" | ">" | "=" | "!" | "+" | "-" | "*" | "/" | "`" | "^"]
digit		[0-9]
id			{letter}({letter}|{digit})*
number		({digit})+
%%
"#!/bin/bash"						return MANDATORY;
"#!/bin/sh"							return MANDATORY;
"#".*								;
" "									;
"while"								{ yylval = strdup(yytext) ;return WHILE; 	}
"for"								{ yylval = strdup(yytext) ;return FOR; 		}
"if"								{ yylval = strdup(yytext) ;return IF; 		}
"fi"								{ yylval = strdup(yytext) ;return FI; 		}
"else"								{ yylval = strdup(yytext) ;return ELSE; 	}
"else if"							{ yylval = strdup(yytext) ;return ELIF; 	}
"then"								{ yylval = strdup(yytext) ;return THEN; 	}
"seq"								{ yylval = strdup(yytext) ;return SEQ; 		}
"break"								{ yylval = strdup(yytext) ;return BREAK; 	}
"return"							{ yylval = strdup(yytext) ;return RETURN; 	}
"in"								{ yylval = strdup(yytext) ;return IN; 		}
"do"								{ yylval = strdup(yytext) ;return DO; 		}
"done"								{ yylval = strdup(yytext) ;return DONE; 	}
"function"							{ yylval = strdup(yytext) ;return FUNCTION; }
"echo"								{ yylval = strdup(yytext) ;return ECHO; 	}
"local"								{ yylval = strdup(yytext) ;return LOCAL; 	}
"++"								{ yylval = strdup(yytext) ;return INC; 		}
"--"								{ yylval = strdup(yytext) ;return DEC; 		}
"=="								{ yylval = strdup(yytext) ;return EQ; 		}
<<EOF>>								return END_OF_FILE; 
{id}								{ yylval = strdup(yytext) ;return ID; 		}
{number}							{ yylval = strdup(yytext) ;return NUM; 		}
{symbols}							{ yylval = strdup(yytext) ;return *yytext; 	}
";"									{ yylval = strdup(yytext) ;return TERMINATOR; }
\n									{ l++; yylval = strdup(yytext) ;return TERMINATOR; }
.									;
%%

int main()
{
//	yyin = fopen("input.sh", "r");
	l = 1 ;
	if (yyparse())
		printf("Error\n");
	//close(fp);
	

	// fork and exec the python function

	return 0;
}
