
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     id = 258,
     cst = 259,
     int_val = 260,
     real_val = 261,
     str_val = 262,
     bool_val = 263,
     program = 264,
     end = 265,
     routine = 266,
     endr = 267,
     si = 268,
     then = 269,
     sinon = 270,
     endif = 271,
     dowhile = 272,
     enddo = 273,
     equivalence = 274,
     read = 275,
     write = 276,
     call = 277,
     sc = 278,
     cm = 279,
     gparen = 280,
     dparen = 281,
     plus = 282,
     minus = 283,
     mult = 284,
     divis = 285,
     egale = 286,
     integer = 287,
     character = 288,
     real = 289,
     logical = 290,
     dimension = 291,
     dp = 292,
     eq = 293,
     ou = 294,
     et = 295,
     gt = 296,
     ge = 297,
     ne = 298,
     le = 299,
     lt = 300
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 11 "synt.y"

    int integer;
	float real;
    char* str;



/* Line 1676 of yacc.c  */
#line 105 "synt.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


