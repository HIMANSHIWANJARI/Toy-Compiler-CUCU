%{
#include <stdio.h>
#include <stdlib.h>

int yyerror( char *error_message);
int yylex();
extern FILE *lexer_output;
extern FILE *yyin;
extern FILE *yyout;


%}

%token INT CHARS IF ELSE WHILE RETURN;
%token OPR_PAR CLR_PAR OPC_PAR CLC_PAR OPS_PAR CLS_PAR;
%token PLUS NEG MULT DIVD EQUAL ASSIGN NOT_EQUAL;
%token COMMA SEMI AND OR;

%union{
    int number;
    char *string;
}

%left DIVD MULT 
%left PLUS NEG 
%left OPR_PAR CLR_PAR

%token<number> NUMBER
%token<string> ID STRING

%%



PROG:
    PROG_BODY { fprintf(yyout," Program Ended\n"); return 0;}

PROG_BODY:
    PROG_BODY VAR_DEC  
    | PROG_BODY FUN_DEC 
    | PROG_BODY FUNC 
    |  

VAR_DEC:
    INT ID SEMI     { fprintf(yyout," Local Variable:%s \n",$2);}
    | CHARS ID SEMI { fprintf(yyout," Local Variable:%s \n",$2);}

FUN_DEC:
    FUNC_HEADER SEMI

FUNC :
    FUNC_HEADER FUNC_BODY


FUNC_HEADER:
    INT ID OPR_PAR FUNC_PAR CLR_PAR         { fprintf(yyout," FUNC HEADER: %s \n",$2);}
    | CHARS ID OPR_PAR FUNC_PAR CLR_PAR     { fprintf(yyout," FUNC HEADER: %s \n",$2);}

FUNC_PAR:
    FUNC_PAR COMMA INT ID                   { fprintf(yyout," Function Argument: %s ",$4);}
    | FUNC_PAR COMMA CHARS ID               { fprintf(yyout," Function Argument: %s ",$4);}
    | INT ID                                { fprintf(yyout," Function Argument: %s \n",$2);}
    | CHARS ID                              { fprintf(yyout," Function Argument: %s \n",$2);}
    |                                       { fprintf(yyout,"\n");}





FUNC_BODY:
    OPC_PAR STMTS CLC_PAR                   { fprintf(yyout," Function Body Ended\n");}

FUNC_CALL:
    ID OPR_PAR FUNC_ARU CLR_PAR SEMI        { fprintf(yyout," FUNC CALL\n");}


FUNC_ARU:
    FUNC_ARU COMMA EXPR
    | FUNC_ARU COMMA ID ASSIGN EXPR         {fprintf(yyout," VAR: %s Assigned a value ",$3);}
    | EXPR                                  
    | ID ASSIGN EXPR                        {fprintf(yyout," VAR: %s Assigned a value ",$1);}
    | FUNC_ARU COMMA STRING                 
    | STRING
    | FUNC_ARU COMMA ID ASSIGN STRING       { fprintf(yyout," VAR: %s Assigned a value ",$3);}
    | ID ASSIGN STRING                      {fprintf(yyout," VAR: %s Assigned a value ",$1);}
    |                                       { fprintf(yyout,"\n");}


STMTS:
    STMTS STMT 
    |

STMT: 
    FUN_DEC   
    | VAR_DEC  
    | VAR_ASG  
    | VAR_DEC_ASG  
    | COND_STMT   
    | FUNC_CALL   
    | RETURN ID SEMI                                { fprintf(yyout," RETURN From Function ");}

VAR_ASG:
    ID ASSIGN EXPR SEMI                             { fprintf(yyout," Local Variable:%s \n",$1);}
    | ID ASSIGN STRING SEMI                         { fprintf(yyout," Local Variable:%s \n",$1);}
    | ID ASSIGN ID OPS_PAR ID CLS_PAR SEMI          { fprintf(yyout," Local Variable:%s \n",$1);}
    | ID ASSIGN FUNC_CALL                           { fprintf(yyout," Local Variable:%s \n",$1);}

VAR_DEC_ASG:
    INT ID ASSIGN EXPR SEMI                         { fprintf(yyout," Local Variable:%s \n",$2);}
    | CHARS ID ASSIGN STRING SEMI                   { fprintf(yyout," Local Variable:%s \n",$2);}
    | CHARS ID ASSIGN ID OPS_PAR ID CLS_PAR SEMI    { fprintf(yyout," Local Variable:%s \n",$2);}
    | INT ID ASSIGN FUNC_CALL                       { fprintf(yyout," Local Variable:%s \n",$2);}


EXPR:
    OPERAND
    | EXPR PLUS EXPR
    | EXPR MULT EXPR
    | EXPR DIVD EXPR
    | EXPR NEG EXPR
    | OPR_PAR EXPR CLR_PAR 

OPERAND:
    NUMBER   { fprintf(yyout," CONST-:%d ",$1);}
    | ID     { fprintf(yyout," VAR: %s ",$1);}


COND_STMT:
    WHILE OPR_PAR BOOL_EXPR { fprintf(yyout,"\n");} CLR_PAR OPC_PAR STMTS CLC_PAR       { fprintf(yyout," WHILE LOOP ENDED\n");}
    | IF OPR_PAR BOOL_EXPR  CLR_PAR OPC_PAR  STMTS CLC_PAR                                      { fprintf(yyout," IF STATEMENT ENDED\n");}
    | IF OPR_PAR BOOL_EXPR  CLR_PAR OPC_PAR STMTS CLC_PAR ELSE OPC_PAR STMTS CLC_PAR            { fprintf(yyout," IF ELSE STATEMENT ENDED\n");}
    
BOOL_EXPR:
    BOOL_EXPR BOOL_OP OPERAND CHECK OPERAND  
    | OPERAND CHECK OPERAND                                         
    | BOOL_EXPR BOOL_OP ID OPS_PAR OPERAND CLS_PAR CHECK STRING         
    | ID OPS_PAR OPERAND CLS_PAR CHECK STRING                       
    | BOOL_EXPR BOOL_OP OPERAND                                     
    | OPERAND
    |                                                               

BOOL_OP:
    AND                                                             { fprintf(yyout," AND ");}
    | OR                                                            { fprintf(yyout," OR ");}

CHECK:
    EQUAL                                                           { fprintf(yyout," EQUALITY TEST ");}
    | NOT_EQUAL                                                     { fprintf(yyout," NOT-EQUALITY TEST ");}

%%




int yyerror(char * text)
{
    fprintf(yyout,"Synatax Error\n");
}


int main(int argc , char *argv[])
{
    yyin = fopen("Sample1.cu","r");
    lexer_output = fopen("Lexer.txt","w");
    yyout = fopen("Parser.txt","w");
    yyparse();
    return 0;
}