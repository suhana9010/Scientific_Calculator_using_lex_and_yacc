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
sin {return SIN;}	
cos {return COS;}	
tan return TAN;		
log return LOG;		
sqrt return SQRT;
sinh return SINH;
cosh return COSH;
tanh return TANH;
asin return ASIN;
acos return ACOS;
atan return ATAN;
pow return POW;	
[\t];
\n      return 0;
.       return yytext[0];


%%
int yywrap()
{
return 1;
}
