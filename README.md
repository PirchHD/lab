# lab
Calculator. calculator. I studied flex/lex

compile: lex *.l && yacc -d *.y && gcc -o calc *.c -lfl -lm
