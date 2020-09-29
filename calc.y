%{
#include<stdio.h>
#include <math.h>
#include <stdlib.h>
#include <alloca.h>
#include <stddef.h>
#include <ctype.h>


void yyerror(char *);
int yylex(void);

%}
%union				//to define possible symbol types
{ double p;}
%token L_BRACKET R_BRACKET
%token<p>num
%token ADD SUB MUL DIV
%token PI LOG
%token SQRT POW 
%token ABS
%token SIN COS TAN ASIN ACOS ATAN SINH COSH TANH 

/*Defining the Precedence and Associativity*/
%left SUB ADD		//lowest precedence
%left MUL DIV              //highest precedence
%left POW SQRT 
%nonassoc uminu			//no associativity
%left L_BRACKET R_BRACKET
%type<p>exp			//Sets the type for non - terminal
%type<p>constant
%%

/* for storing the answer */
ss: exp {printf("Result =%g\n",$1);}

/* for binary arithmatic operators */
exp :   exp ADD exp      { $$=$1+$3; }
       |exp SUB exp      { $$=$1-$3; }
       |exp MUL exp      { $$=$1*$3; }
       |exp DIV exp      {
                               if($3==0)
                               {
                                       yyerror("\n Undefined: can't divide by zero\n");
//exit(0);
                               }
                               else $$=$1/$3;
                       }
       |SUB exp         {$$=-$2;}

       |exp POW exp      {$$=pow($1,$3);}
       |SIN L_BRACKET exp R_BRACKET   {$$=sin($3);}
       |COS L_BRACKET exp R_BRACKET  {$$=cos($3);}
       |TAN L_BRACKET exp R_BRACKET  {$$=tan($3);}
       |ASIN L_BRACKET exp R_BRACKET  {$$=asin($3);}
       |ACOS L_BRACKET exp R_BRACKET  {$$=acos($3);}
       |ATAN L_BRACKET exp R_BRACKET  {$$=atan($3);}
       |SINH L_BRACKET exp R_BRACKET {$$=sinh($3);}
       |COSH L_BRACKET exp R_BRACKET  {$$=cosh($3);}
       |TANH L_BRACKET exp R_BRACKET  {$$=tanh($3);}
       |LOG L_BRACKET exp R_BRACKET   {$$=log($3);}
       |SQRT L_BRACKET exp R_BRACKET {$$=sqrt($3);}
       |ABS L_BRACKET exp R_BRACKET  { $$ = abs($3);}
       |L_BRACKET exp R_BRACKET      {$$=$2;}
       |num
        |constant;
       
         
   
constant:PI {$$=3.142;}
    
%%

/* extern FILE *yyin; */
void main()
{
       printf("\n      YOUR CALCULATOR IS READY!!       \n");
       do
       {        printf("\nEnter an expression:\n");
       		     yyparse();	
       }while(1);

}

void yyerror(char *s)			
{
       /*printf("Invalid Expression");*/
       printf("\n%s",s);
}

