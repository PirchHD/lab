%{
#include "global.h"
#include "y.tab.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int a,b,c;
%}

white		[ \t]+

digit		[0-9]
real 		([1-9][0-9]*|0)(\.[0-9]+)?((e|E)(\+|\-)?[0-9]+)?
integer 	{digit}+

A ({real})
B ({real})
C ({real})
delta ({A}[x][/^][2])[+-]({B}[x])[+-]({C})


%%

{white} 	{ /* We ignore white characters */ }

{real}	{
		  yylval=atof(yytext);
		  return(NUMBER);
		}

{delta} {
	int wynik = 0;
char tabA[yyleng];
char tabB[yyleng];
char tabC[yyleng];

	int tempI=0;
	for(int i = 0; i < yyleng; i++){
		tabA[i] = yytext[i];
		if(yytext[i+1] == 'x' && yytext[i+2] == '^' && yytext[i+3] == '2'){
				tempI = i+4;
				break;
		}
	}

	int j = 0;

	for(int i = tempI; i < yyleng; i++){

		tabB[j] = yytext[i];

		j++;
		if(yytext[i+1] == 'x' && (yytext[i+2] == '+' || yytext[i+2] == '-')){
				tempI= i+2;
				break;
		}
	}

	j = 0;
	for(int i = tempI; i < yyleng; i++){
		tabC[j] = yytext[i];
		j++;
	}

  int A = atoi(tabA), B = (atoi(tabB)), C = (atoi(tabC));

	printf("A to jest %d",(atoi(tabA)));
	printf("\n");
	printf("B to jest %d",(atoi(tabB)));
	printf("\n");
	printf("C to jest %d",(atoi(tabC)));

	int delta = (B*B) - 4 * A * C;

	printf("\n delta = %d",delta);

	if(delta < 0){
		printf("/n Delta ujemna :C nie ma rozwiazan");
	}else if(delta == 0) {
		printf("\n");
		printf("Delta ma jedno rozwiazanie");
		printf("\n");
		printf("x0 = %d", ( (-B)/(2*A) ) );
	}else if(delta > 0){
		printf("\n");
		printf("Delta ma dwa rozwiazania");
		printf("\n");
		printf("x1 = %f		i 	x2 = %f", ( ((-B) - sqrt(delta) )/(2*A) ), ( ((-B) + sqrt(delta) )/(2*A) ) );
	}

}


"+"		return(PLUS);
"-"		return(MINUS);
"*"		return(MULT);
"/"		return(DIV);
"("		return(LP);
")"		return(RP);
"||"	return(OR);
"&&" 	return(AND);
"=>" return(IMP);
"^" return(POT);
"sqrt(" return(PIERW);
"SIN(" return(SIN);
"COS(" return(COS);
"TAN(" return(TAN);
"|" return(LINE);
"LOG(" return(LOG);

"\n"	return(END);
