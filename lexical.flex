%{
	#include "parser.tab.h"	
%}

%option yylineno

DIGIT [0-9]
LETTER [a-zA-Z]

%%
","								{return COMMA;}
"<="							{return LE;}
">="							{return GE;}
"<"								{return LT;}
">"								{return GT;}
"=="							{return IE;}
"!="							{return NE;}
("LOG"|"log")					{return LOG;}
("ATAN"|"atan")					{return ATAN;}
("ACOS"|"acos")					{return ACOS;}
("ASIN"|"asin")					{return ASIN;}
("TAN"|"tan")					{return TAN;}
("COS"|"cos")					{return COS;}
("SIN"|"sin")					{return SIN;}
("SQRT"|"sqrt")					{return SQRT;}
("POW"|"pow")					{return POW;}
{LETTER}({LETTER}|{DIGIT})* { 	yylval.name=(char*)malloc(sizeof(yytext)+1);
								strcpy(yylval.name,yytext);
								return IDENT;
								}
([1-9])([0-9])*("."{DIGIT}+)?		{yylval.val=atof(yytext); return CONST;}	

[' '\t]+		{// White space}

\+			{return ADD;}
\-			{return SUB;}
\*			{return MUL;}
\/			{return DIV;}
\%			{return MOD;}
\(			{return LPAR;}
\)			{return RPAR;}
\=			{return EQU;}
(\n) 		 return EOL;}

%%