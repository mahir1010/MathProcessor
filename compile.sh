cd ./src
bison -d parser.y
flex lexical.flex
gcc *.c -o ../MathProcessor -lfl -lm