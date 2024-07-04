Name : Himanshi Wanjari

Entry No  2022CSB1085



Commands to run the program :

For Sample1.cu : 

flex cucu.l
bison -d cucu.y
gcc lex.yy.c y.tab.c

For Sample2.cu : 

in cucu.y file in line 163 {yyin = fopen("Sample1.cu","r");} change it to :
yyin = fopen("Sample2.cu","r");

Commands:

flex cucu.l
bison -d cucu.y
gcc lex.yy.c y.tab.c


cucu.l

This file contains lexer code is written in Flex, a tool for generating lexical analyzers. It defines a set of rules to tokenize input text, identifying various tokens such as integers, characters, identifiers, keywords like 'if', 'else', 'while', arithmetic and logical operators, and punctuation symbols like parentheses, braces, and brackets.Each rule specifies a pattern to match in the input text and an action to perform when a match is found. For example, when an integer is encountered, the lexer outputs a token indicating its type and value. Similarly, when a keyword like 'if' or 'else' is found, it outputs a token representing a conditional statement.The lexer also handles comments, ignoring whitespace characters, and recognizes strings enclosed in double quotes. It writes the recognized tokens along with any associated information (such as values for numbers or identifiers) to an output file specified by lexer_output.

Overall, this lexer serves as the initial step in the compilation process, breaking down the input source code into meaningful tokens for further processing by the parser


cucu.y

This code defines a compiler for a simple programming language using Flex and Bison. In the lexer section, patterns are specified to tokenize input text, identifying various elements such as integers, characters, keywords like 'if', 'else', and 'while', along with operators and punctuation symbols. Tokens are outputted to the Lexer.txt file for further processing. The parser section defines the grammar rules of the language, specifying the structure of programs. It includes rules for variable and function declarations, function calls, arithmetic and logical expressions, conditional statements, and return statements. Each rule includes actions to perform, such as printing information about the parsed program structure to the Parser.txt file. Error handling is implemented through the yyerror function to manage syntax errors during parsing. Finally, the main function  process by opening input and output files, parsing the input file using the defined grammar rules, and generating parsing results.


OUTPUT FILES: 

By this Lexer.txt and Parser.txt generates.