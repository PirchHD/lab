%{
#include "global.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
%}

%token	NUMBER MINUS PLUS DIV MULT LP RP AND OR IMP POT PIERW SIN
%token COS TAN LINE LOG
%token	END


%start Input
%%

Input:
	  /* Empty */
	| Input Line
	;

Line:
	  END
	| S END		{ printf("Wynik: %f\n",$1); }
	;

S:
	  T								{ $$=$1; }
	| S PLUS T  			{ $$=$1+$3; }
  | S MINUS T       { $$=$1-$3; }
	;

T:
		Q			{$$=$1;}
	| T MULT Q {$$=$1*$3;}
	| T DIV Q {$$=(div($1,$3)).quot;}
	| T POT Q {$$=pow($1,$3);}
;

Q:
		R			{$$=$1;}
	| Q OR R {$$=(int)$1||(int)$3;}
	| Q AND R {$$=(int)$1&&(int)$3;}
	| Q IMP R {$$=!(int)$1||(int)$3;}
;


R:
		NUMBER {$$=$1;}
	| SIN S RP 		{$$=sin($2);}
	| COS S RP  	{$$=cos($2);}
	| TAN S RP		{$$=tan($2);}
	| PIERW S RP 	{$$=sqrt($2);}
	| LP S RP	{$$=$2;}
	| LINE S LINE {$$=abs($2);}
	| LOG S RP {$$=log($2);}
	| MINUS NUMBER {$$=-$2;}
;



%%

int yyerror(char *s) {
  printf("%s\n",s);
}

int main(void) {
  yylex();
}
