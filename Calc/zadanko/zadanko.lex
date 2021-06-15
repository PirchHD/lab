%{
  int number_lines = 0, number_char = 0;
%}
%%
\n  ++number_lines; ++number_char;
.   ++number_char;

%%
main(){
  yylex();
  printf("# of lines = %d, # of chars = %d \n", number_lines, number_char );
}
