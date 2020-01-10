# MathProcessor
Expression Evaluator

The Lexer is generated with Flex while the Parser is generated with Bison.
## Grammar
```
S ⇒ EOL | IDENT EQU EXPR EOL | EXPR EOL

IDENT ⇒ {LETTER}({LETTER}|{DIGIT})*

EXPR ⇒  SINGLEPARAMFUNC LPAR EXPR RPAR  |
        POW LPAR EXPR COMMA EXPR RPAR   |
        EXPR LT EXPR | EXPR GT EXP R | EXPR LE EXPR | EXPR GE EXPR | EXPR NE EXPR | EXPR IE EXPR |
        CONST |
        EXPR ADD EXPR | EXPR SUB EXPR | EXPR DIV EXPR | EXPR MUL EXPR | EXPR MOD EXPR | 
        LPAR EXPR RPAR |
        IDENT

SINGLEPARAMFUNC ⇒ SQRT | SIN | COS | TAN | LOG | ASIN | ACOS | ATAN
```
![SCRSHOT](https://raw.githubusercontent.com/mahir1010/MathProcessor/master/SCRSHOT/SCRSHOT.png)
