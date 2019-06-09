/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELSE = 259,
    ID = 260,
    NUM = 261,
    WHILE = 262,
    FOR = 263,
    CONTINUE = 264,
    BREAK = 265,
    RETURN = 266,
    FUNCTION = 267,
    SEQ = 268,
    ECHO = 269,
    LOCAL = 270,
    DO = 271,
    DONE = 272,
    THEN = 273,
    IN = 274,
    FI = 275,
    TERMINATOR = 276,
    MANDATORY = 277,
    END = 278,
    LT = 279,
    GT = 280,
    EQ = 281,
    LE = 282,
    GE = 283,
    NE = 284,
    AND = 285,
    OR = 286,
    INC = 287,
    DEC = 288,
    ELIF = 289,
    END_OF_FILE = 290,
    STRING = 291
  };
#endif
/* Tokens.  */
#define IF 258
#define ELSE 259
#define ID 260
#define NUM 261
#define WHILE 262
#define FOR 263
#define CONTINUE 264
#define BREAK 265
#define RETURN 266
#define FUNCTION 267
#define SEQ 268
#define ECHO 269
#define LOCAL 270
#define DO 271
#define DONE 272
#define THEN 273
#define IN 274
#define FI 275
#define TERMINATOR 276
#define MANDATORY 277
#define END 278
#define LT 279
#define GT 280
#define EQ 281
#define LE 282
#define GE 283
#define NE 284
#define AND 285
#define OR 286
#define INC 287
#define DEC 288
#define ELIF 289
#define END_OF_FILE 290
#define STRING 291

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
