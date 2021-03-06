%{
	
	#include "symtab.h"
	#include "math.h"

	void yyerror(const char *s);
	extern int yylex();
	extern int yyparse();
	extern int yy_scan_string();
	extern int yylineno;
%}
%union {
	double val;
	char  *name;
	double (*fn)(double inp);
}
%locations
%token <val> CONST
%token <name> IDENT
%token ADD SUB DIV MUL MOD LPAR RPAR EQU COMMA
%token POW SQRT SIN COS TAN LOG ASIN ACOS ATAN
%token LE GE IE LT GT NE
%token EOL

%right EQU
%left IE NE
%left LT LE GT GE
%left ADD SUB
%left DIV MUL MOD
%left LPAR RPAR


%start INPUT
%type  <val> EXPR
%type  <fn> SINGLEPARAMFUNC
%%
INPUT 	: EOL
		| IDENT EQU EXPR EOL{	
								Table *record =lookup($1);
								if(record==NULL)
								insert_record($1,$3);
								else
								record->data=$3;
							}
		| EXPR EOL{if($1==$1){printf("%lf\n",$1);}}
		| %empty
		;

EXPR	: SINGLEPARAMFUNC LPAR EXPR RPAR {$$=$1($3);}
		| POW LPAR EXPR COMMA EXPR RPAR {$$=pow($3,$5);}
		| EXPR LT EXPR {if($1<$3){printf(BOLDGREEN"True\n"WHITE);}else{printf(BOLDRED"False\n"WHITE);}$$=NAN;}
		| EXPR GT EXPR {if($1>$3){printf(BOLDGREEN"True\n"WHITE);}else{printf(BOLDRED"False\n"WHITE);}$$=NAN;}
		| EXPR LE EXPR {if($1<=$3){printf(BOLDGREEN"True\n"WHITE);}else{printf(BOLDRED"False\n"WHITE);}$$=NAN;}
		| EXPR GE EXPR {if($1>=$3){printf(BOLDGREEN"True\n"WHITE);}else{printf(BOLDRED"False\n"WHITE);}$$=NAN;}
		| EXPR NE EXPR {if($1!=$3){printf(BOLDGREEN"True\n"WHITE);}else{printf(BOLDRED"False\n"WHITE);}$$=NAN;}
		| EXPR IE EXPR {if($1==$3){printf(BOLDGREEN"True\n"WHITE);}else{printf(BOLDRED"False\n"WHITE);}$$=NAN;}
		| CONST {$$=$1;}
		| EXPR ADD EXPR	{$$=$1+$3;}
		| EXPR SUB EXPR	{$$=$1-$3;}
		| EXPR DIV EXPR	{$$=$1/$3;}
		| EXPR MUL EXPR	{$$=$1*$3;}
		| EXPR MOD EXPR	{$$=(int)$1%(int)$3;}
		| LPAR EXPR RPAR {$$=$2;}
		| IDENT {
							Table *record=lookup($1);
							if(record==NULL){
								printf(BOLDRED"Undeclared Variable %s\n"WHITE,$1);
								return -1;
							}
							$$=record->data;
						}
		;
SINGLEPARAMFUNC : 	SQRT 	{$$=&sqrt;}
				|	SIN 	{$$=&sin;}
				|	COS 	{$$=&cos;}
				|	TAN 	{$$=&tan;}
				|	LOG 	{$$=&log;}
				|	ASIN 	{$$=&asin;}
				|	ACOS 	{$$=&acos;}
				|	ATAN	{$$=&atan;}
				;

%% 

int main(int argc, char **argv) {

	printf("\nThis program is created  by ");printf(BOLDRED "Mahir Patel" WHITE);printf(", as an alternative to the written assignments for Compiler Design\nThe parser is generated by BISON and Lexical analyzer is generated by FLEX \n"BLUE"Supported Features:\n1->Arithmetic Operations (with parentheses support)\n2->Variable declaration\n3->Relational Operations\n4->Math Functions with Nesting[POW,SQRT,SIN,COS,TAN,LOG,ASIN,ACOS,ATAN]"WHITE"\n\n");
	printf(BOLDGREEN">>"WHITE);
	char input[256];
	while(1){
	fgets(input,256,stdin);
	yy_scan_string(input);
	yyparse();
	printf(BOLDGREEN">>"WHITE);
	}
}
void yyerror (char const *s)
{
  fprintf (stderr,BOLDRED "Line number %d %s\n" WHITE,yylineno, s);
}
