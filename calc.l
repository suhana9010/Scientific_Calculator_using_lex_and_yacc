%option noyywrap
%{

#include <math.h>
#include"y.tab.h"
       
%}


%%

[0-9]+|[0-9]*\.[0-9]+	{
                       		yylval.p = atof(yytext);
                       		return num;		
                       	}
"+" {return ADD;}
"-" {return SUB;}
"*" {return MUL;}
"/" {return DIV;}
"^" {return POW;}
"(" {return L_BRACKET;}
")" {return R_BRACKET;}
"pi" {return PI;}
"e"  {return E;}
"++" {return INC;}
"--" {return DEC;}
"&&" {return AND;}
"||" {return OR;}
"^^" {return XOR;}
"~"  {return NOT;}
"<<" {return LEFTSHIFT;}
">>" {return RIGHTSHIFT;}
"%"  {return MOD;}
","  {return COMMA;}
"<"  {return LESSER;}
">"  {return GREATER;}
"<=" {return LESSERTHAN;}
">=" {return GREATERTHAN;}
"=="  {return EQUAL;}
"!=" {return NOTEQUAL;}
"="  {return ASSIGN;}
"if" {return IF;}
"else" {return ELSE;}
"deg"  {return D;}
sin   return SIN;	
cos   return COS;	
tan   return TAN;
cosec return COSEC;
sec   return SEC;
cot   return COT;		
log   return LOG;
ln    return LN;		
sqrt  return SQRT;
sinh  return SINH;
cosh  return COSH;
tanh  return TANH;
cosech return COSECH;
sech   return SECH;
coth   return COTH;
asin  return ASIN;
acos  return ACOS;
atan  return ATAN;
acosec return ACOSEC;
asec   return ASEC;
acot   return ACOT;
pow   return POW;
abs     return ABS;
fact    return FACTORIAL;
floor   return FLOOR;
ceil    return CEIL;
round   return ROUND;
bi_dec  return BI_DEC;
dec_bi  return DEC_BI;

[\t];
\n      return 0;
.       return yytext[0];


%%

