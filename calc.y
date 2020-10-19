%{
#include<stdio.h>
#include <math.h>
#include <stdlib.h>
#include <alloca.h>
#include <stddef.h>
#include <ctype.h>


void yyerror(char *);
int yylex(void);
float fact(int n){
  int k;
  float res= 1;
 
  for (k=1; k<=n; k++)
    res = res * k;
 
  return res;
}


long int bi_dec(long int n)  {
  long int rem,sum=0,base=0;
  while(n>0)
  {
  rem=n%10;
  n=n/10;
  sum=sum+rem*pow(2,base);
  base+=1;
  }

return sum;
}
long int dec_bi(long int n){
    long bin=0;
    int rem,k=1;
    while(n>0){
       rem=n%2;
       n=n/2;
       bin=bin+rem*k;
       k=k*10;
       }
    return bin;
}
int error=0;
%}


%union				//to define possible symbol types
{ double p;}
%token L_BRACKET R_BRACKET
%token<p>num
%token ADD SUB MUL DIV FLOOR CEIL ROUND
%token PI LOG FACTORIAL LN E BI_DEC DEC_BI
%token SQRT POW COMMA MOD
%token ABS ASSIGN IF ELSE D
%token SIN COS TAN ASIN ACOS ATAN SINH COSH TANH INC DEC AND OR XOR NOT LEFTSHIFT RIGHTSHIFT LESSER GREATER LESSERTHAN GREATERTHAN EQUAL NOTEQUAL

/*Defining the Precedence and Associativity*/
%left SUB ADD		//lowest precedence
%left MUL DIV MOD             //highest precedence
%left POW SQRT 
%left INC DEC LOG 
%nonassoc uminu			//no associativity
%left OR AND XOR LEFTSHIFT RIGHTSHIFT
%left LESSER GREATER LESSERTHAN GREATERTHAN EQUAL NOTEQUAL 
%right ASSIGN
%right NOT
%left L_BRACKET R_BRACKET
%type<p>exp			//Sets the type for non - terminal
%type<p>constant
%%

/* for storing the answer */
ss: exp {if(error==0) printf("Result = %g\n",$1);}

/* for binary arithmatic operators */
exp :   exp ADD exp      { $$=$1+$3; }
       |exp SUB exp      { $$=$1-$3; }
       |exp MUL exp      { $$=$1*$3; }
       |exp DIV exp      {if($3!=0){$$=$1/$3;} else yyerror("Divide by zero error\n");}
       |SUB exp         {$$=-$2;}

       |exp POW exp      {$$=pow($1,$3);}
       |exp MOD exp      {if($3!=0){$$=fmod($1,$3);} else yyerror("Divide by zero error\n");}
       |LOG L_BRACKET exp R_BRACKET   {$$=log10($3);}
       |LN L_BRACKET exp R_BRACKET   {$$=log($3);}
       |SQRT L_BRACKET exp R_BRACKET {$$=sqrt($3);}
       |ABS L_BRACKET exp R_BRACKET  { $$ = abs($3);}
       
       |exp INC                  {$$=$1+1;}
       |exp DEC                  {$$=$1-1;}
       |exp OR exp       	{$$=(int)$1||(int)$3;}
       |exp AND exp      	{$$=(int)$1&&(int)$3;}
       |exp XOR exp      	{$$=(int)$1^(int)$3;}
       |NOT L_BRACKET exp R_BRACKET   {if($3==1){$$=0;} else 1;}
       |exp LEFTSHIFT exp        {$$ = (int)$1<<(int) $3;}
       |exp RIGHTSHIFT exp       {$$ = (int)$1>>(int) $3;}

       |exp LESSER exp     	{$$ = $1<$3;}
       |exp GREATER exp  	{$$ = $1>$3;}
       |exp LESSERTHAN exp 	{$$ = $1<=$3;}
       |exp GREATERTHAN exp      {$$ = $1>=$3;}
       |exp EQUAL exp            {$$ = $1==$3;}
       |exp NOTEQUAL exp         {$$ = $1!=$3;}
       
       
       |FACTORIAL L_BRACKET exp R_BRACKET  { $$ = fact((int)$3);}
       |FLOOR L_BRACKET exp R_BRACKET      { $$ = floor($3);}
       |CEIL L_BRACKET exp R_BRACKET       { $$ = ceil($3);}
       |ROUND L_BRACKET exp R_BRACKET      { $$ = round($3);}
      
       |SIN L_BRACKET exp R_BRACKET   {$$=sin($3);}
       |COS L_BRACKET exp R_BRACKET  {$$=cos($3);}
       |TAN L_BRACKET exp R_BRACKET  {$$=tan($3);}
       |ASIN L_BRACKET exp R_BRACKET  {if($5<=1&&$5>=-1){$$=asin($5);} else(yyerror("Out of range\n"));}
       |ACOS L_BRACKET exp R_BRACKET  {if($5<=1&&$5>=-1){$$=acos($5);} else(yyerror("Out of range\n"));}
       |ATAN L_BRACKET exp R_BRACKET  {$$=atan($3);}
       |SINH L_BRACKET exp R_BRACKET {$$=sinh($3);}
       |COSH L_BRACKET exp R_BRACKET  {$$=cosh($3);}
       |TANH L_BRACKET exp R_BRACKET  {$$=tanh($3);}
       |BI_DEC L_BRACKET exp R_BRACKET
		{$$=bi_dec((float)$3);}
       |DEC_BI L_BRACKET exp R_BRACKET
		{$$=dec_bi((int)$3);}
       |L_BRACKET exp R_BRACKET      {$$=$2;}
       |num
       |constant;
constant:PI {$$=3.142;}
         |E {$$=2.71828;}
	|D {$$=180;}
       
    
%%

/* extern FILE *yyin; */
void main()
{
       printf("\n      YOUR SCIENTIFIC CALCULATOR IS READY!!       \n");
       printf("\n");        
       do
       {   
		printf("\n");        
		printf("Enter a valid erpression:\n");
       		     yyparse();	
       }while(1);

}

void yyerror(char *s)			
{
       /*printf("Invalid Expression");*/
       printf("\n%s",s);
       error=1;
}
