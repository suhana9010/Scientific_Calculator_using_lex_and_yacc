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
"|"  {return B_OR;}
"&"  {return B_AND;}
"!"  {return NOT;}
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
"quit" {return QUIT_CMD;}
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
dec_oct return DEC_OCT;
oct_dec return OCT_DEC;
permt   return PERMT;
comb    return COMB;
mode    return MODE;
hcf     return HCF;
lcm     return LCM;
max     return MAX;
min     return MIN;
avg     return AVG;
pct     return PCT;
cel_fah   return CEL_FAH; 
fah_cel   return FAH_CEL; 
rcpl      return RCPL;


[\t];
[a-z] {
 yylval.id = *yytext - 'a';
 return VARIABLE;
 } 
\n      return 0;
.       return yytext[0];


%%
