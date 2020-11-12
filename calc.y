%{
#include<stdio.h>
#include <math.h>
#include <stdlib.h>
#include <alloca.h>
#include <stddef.h>

void yyerror(char *s);
int yylex(void);
int sym[26]; 
double cel_fah(double cel){
	return cel*9/5+32;}

double fah_cel(double fah){ 
	return (fah-32)*5/9;}
float fact(float n){
  
    float k, res= 1;
    for (k=1; k<=n; k++)
       res = res * k;
 
    return res;
}


long int bi_dec(long int n)  {
  long int rem,sum=0,base=0;
     while(n>0){
     rem=n%10;
     n=n/10;
     sum=sum+rem*pow(2,base);
     base+=1;
  }

return sum;
}
long int dec_bi(long int n){
    long int bin=0;
    int rem,k=1;
    while(n>0){
       rem=n%2;
       n=n/2;
       bin=bin+rem*k;
       k=k*10;
       }
    return bin;
}
int dec_oct(int n){
    int oct=0,i=1;
    while(n>0){
       oct=oct+(n%8)*i;
        n=n/8;
        i=i*10;
    }
    return oct;
}
int oct_dec(int n){
    int dec=0,i=0;
    while(n>0){
        dec=dec+(n%10)*pow(8,i);
        i++;
        n=n/10;
    }
    i=1;
    return dec;
}
int hcf(int x,int y){
   int res=0;
   for(int i=1; i<=x||i<=y;i++){
      if(x%i==0 && y%i==0)
          res=i;
   }
   return res;
}
int lcm(int x,int y){
    int k;
    k=(x>y) ? x: y;
    while(1){
       if(k%x==0 && k%y==0){
          break;
       }
       k+=1;
    }
    return k;
}


int flag=0;
int m=0,count;
%}


%union				//to define possible symbol types
{ double p;
  char id;}
%token L_BRACKET R_BRACKET
%token<p>num 
%token<id>VARIABLE
%token ADD SUB MUL DIV FLOOR CEIL ROUND PI LOG FACTORIAL LN E BI_DEC DEC_BI DEC_OCT OCT_DEC SQRT POW COMMA MOD ABS ASSIGN IF ELSE 
%token SIN COS TAN ASIN ACOS ATAN SINH COSH TANH COSEC SEC COT COSECH SECH COTH ACOSEC ASEC ACOT INC DEC AND OR XOR NOT B_OR B_AND LEFTSHIFT
	 RIGHTSHIFT LESSER GREATER LESSERTHAN GREATERTHAN EQUAL NOTEQUAL QUIT_CMD PERMT COMB MODE HCF LCM MAX MIN AVG PCT CEL_FAH FAH_CEL 
	 RCPL 
/*Defining the Precedence and Associativity*/
%left SUB ADD		//lowest precedence
%left MUL DIV MOD            //highest precedence
%left POW SQRT 
%left INC DEC LOG 
%nonassoc RCPL		//no associativity
%nonassoc VARIABLE
%left B_OR B_AND
%left OR AND XOR LEFTSHIFT RIGHTSHIFT
%left LESSER GREATER LESSERTHAN GREATERTHAN EQUAL NOTEQUAL 
%right ASSIGN 
%right NOT
%left L_BRACKET R_BRACKET
%type<p>exp        //Sets the type for non - terminal
%type<p>min_list	             
%type<p>max_list 
%type<p>hcf_list
%type<p>lcm_list
%type<p>avg_list
%type<p>constant 
%type<p>conversion

%%

/* for storing the answer */
ss: exp {if(flag==0) 
           printf("Result = %g\n",$1);}                             //For binary arithmatic operators 
exp :  exp ADD exp      { $$=$1+$3; }
       |exp SUB exp      { $$=$1-$3; }
       |exp MUL exp      { $$=$1*$3; }
       |exp DIV exp      {if($3!=0){$$=$1/$3;} 
				else yyerror("Cannot divide by zero\n");}
       |SUB exp         {$$=-$2;}
      

       |exp POW exp      {$$=pow($1,$3);}
       |exp MOD exp      {if($3!=0){$$=fmod($1,$3);}else yyerror("Cannot divide by zero\n");}
       |LOG L_BRACKET exp R_BRACKET   {$$=log10($3);}
       |LN L_BRACKET exp R_BRACKET   {$$=log($3);}
       |SQRT L_BRACKET exp R_BRACKET {$$=sqrt($3);}
       |ABS L_BRACKET exp R_BRACKET  { $$ = abs($3);}
       |RCPL L_BRACKET exp R_BRACKET {$$=1/$3;}                 
       
                                                               //For logical operations
       |exp OR exp       	{$$=(int)$1||(int)$3;}
       |exp AND exp      	{$$=(int)$1&&(int)$3;}
       |exp XOR exp      	{$$=(int)$1^(int)$3;}
       |NOT exp    		{$$=!$2;}
       |exp B_OR exp		{$$=(int)$1|(int)$3;}
       |exp B_AND exp		{$$=(int)$1&(int)$3;}

       |exp INC                  {$$=$1+1;}
       |exp DEC                  {$$=$1-1;}
       |exp LEFTSHIFT exp        {$$ = (int)$1<<(int) $3;}
       |exp RIGHTSHIFT exp       {$$ = (int)$1>>(int) $3;}

                                                              //For all compatative operations
       |exp LESSER exp     	{$$ = $1<$3;}
       |exp GREATER exp  	{$$ = $1>$3;}
       |exp LESSERTHAN exp 	{$$ = $1<=$3;}
       |exp GREATERTHAN exp      {$$ = $1>=$3;}
       |exp EQUAL exp            {$$ = $1==$3;}
       |exp NOTEQUAL exp         {$$ = $1!=$3;}
       
       
       |FACTORIAL L_BRACKET exp R_BRACKET  { $$ = fact((int)$3);}
       |PCT L_BRACKET exp COMMA exp R_BRACKET  {$$=(float)($3/$5)*100; }
       |FLOOR L_BRACKET exp R_BRACKET      { $$ = floor($3);}
       |CEIL L_BRACKET exp R_BRACKET       { $$ = ceil($3);}
       |ROUND L_BRACKET exp R_BRACKET      { $$ = round($3);}

       |SIN L_BRACKET exp  R_BRACKET     {$$= m==1 ? sin($3*3.14159/180): sin($3);}
         |COS L_BRACKET exp  R_BRACKET     {$$= m==1 ? cos($3*3.14159/180): cos($3);}
         |TAN L_BRACKET exp  R_BRACKET     {$$= m==1 ? tan($3*3.14159/180): tan($3);}
         |COSEC L_BRACKET exp R_BRACKET   {$$= m==1 ? 1/sin($3*3.14159/180): 1/sin($3);}
         |SEC L_BRACKET exp R_BRACKET     {$$= m==1 ? 1/cos($3*3.14159/180): 1/cos($3);}
         |COT L_BRACKET exp R_BRACKET     {$$= m==1 ? 1/tan($3*3.14159/180): 1/tan($3);}


         |ASIN L_BRACKET exp R_BRACKET    {if($3<=1&&$3>=-1){$$= m==1 ? asin($3)*180/3.14159 : asin($3);} 
				else(yyerror("Out of range\n"));}
         |ACOS L_BRACKET exp R_BRACKET    {if($3<=1&&$3>=-1){$$= m==1 ? asin($3)*180/3.14159 : asin($3);} 
				else(yyerror("Out of range\n"));}
         |ATAN L_BRACKET exp R_BRACKET    {$$= m==1 ? atan($3)*180/3.14159 : atan($3);}
         |ACOSEC L_BRACKET exp R_BRACKET  {if($3>=1&&$3<=-1){$$= m==1 ? asin(1/$3)*180/3.14159:  asin(1/$3);}
				else(yyerror("Out of range\n"));}
         |ASEC L_BRACKET exp R_BRACKET    {if($3>=1&&$3<=-1){$$= m==1 ? acos(1/$3)*180/3.14159 : acos(1/$3);} 
				else(yyerror("Out of range\n"));}
         |ACOT L_BRACKET exp R_BRACKET    {$$= m==1 ? atan(1/$3)*180/3.14159: atan(1/$3);}


         |SINH L_BRACKET exp R_BRACKET  {$$= m==1 ? sinh($3*3.14159/180): sinh($3);}
         |COSH L_BRACKET exp R_BRACKET  {$$= m==1 ? cosh($3*3.14159/180): cosh($3);}
         |TANH L_BRACKET exp R_BRACKET  {$$= m==1 ? tanh($3*3.14159/180): tanh($3);}
         |COSECH L_BRACKET exp R_BRACKET {if($3!=0) {$$= m==1 ? 1/sinh($3*3.14159/180): 1/sinh($3);}
                                else(yyerror("Out of range\n"));}
         |SECH L_BRACKET exp R_BRACKET {$$= m==1 ? 1/cosh($3*3.14159/180): 1/cosh($3);}
         |COTH L_BRACKET exp R_BRACKET {if($3!=0) {$$= m==1 ? 1/tanh($3*3.14159/180): 1/tanh($3);}
                                else(yyerror("Out of range\n"));}
      
       |PERMT L_BRACKET exp COMMA exp R_BRACKET  {$$=fact($3)/fact($3-$5);}
       |COMB  L_BRACKET exp COMMA exp R_BRACKET  {$$=fact($3)/(fact($5)*fact($3-$5));}

       |MODE ASSIGN exp   {m=$3; flag=-1; if($3==1){
		printf("\nmode switched to degrees\n");} else printf("\nmode switched to radians\n");}

       |HCF L_BRACKET hcf_list R_BRACKET    {$$=$3;}
       |LCM L_BRACKET lcm_list R_BRACKET    {$$=$3;}
       |MAX L_BRACKET max_list R_BRACKET  {$$=$3;}
       |MIN L_BRACKET min_list R_BRACKET  {$$=$3;}
       |AVG L_BRACKET avg_list R_BRACKET  {count+=1; $$=(float)$3/count;}
 
       |VARIABLE { $$ = sym[$1]; } 
       |VARIABLE ASSIGN exp {flag=-1; sym[$1] = $3;}
       |exp L_BRACKET VARIABLE R_BRACKET ADD exp  {$$=-(float)$6/$1;}

       |L_BRACKET exp R_BRACKET      {$$=$2;}
       |num                          {$$=$1;} 
       |QUIT_CMD                     {exit(EXIT_SUCCESS);}
       
       |constant
       |conversion 
       ;

conversion: BI_DEC L_BRACKET exp R_BRACKET
		{$$=bi_dec((float)$3);}
           |DEC_BI L_BRACKET exp R_BRACKET
		{$$=dec_bi((int)$3);}
           |DEC_OCT L_BRACKET exp R_BRACKET
		{$$=dec_oct((int)$3);}
           |OCT_DEC L_BRACKET exp R_BRACKET
		{$$=oct_dec((int)$3);}
           |CEL_FAH L_BRACKET exp R_BRACKET{
                 $$=cel_fah($3);}
           |FAH_CEL L_BRACKET exp R_BRACKET{
                 $$=fah_cel($3);};
constant:PI {$$=3.14159;}
         |E {$$=2.71828;}
         ;
max_list: exp                     {$$=$1;}
          |max_list COMMA exp {$$= $1>$3?$1:$3;}
          ;	
min_list: exp                      {$$=$1;}
          |min_list COMMA exp {$$=$1<$3?$1:$3;}
          ; 
avg_list: exp                     { $$=$1; }
          |avg_list COMMA exp {
		count+=1; $$=($1+$3);}
          ;
hcf_list: exp COMMA exp        {$$=hcf($1,$3);}
          |hcf_list COMMA exp  {$$= hcf($1,$3);} ;
lcm_list: exp COMMA exp        {$$=lcm($1,$3);}
          |lcm_list COMMA exp  {$$= lcm($1,$3);} ; 
%%


/* extern FILE *yyin; */
void main()
{
       printf("\n\033[1;37m                 WELCOME TO YOUR SCIENFIFIC CALCULATOR         \033[0m\n");
       printf("\n");
       printf("\nAccessible Operators:\n + - * / \n < > <= >= == =! \n | && ^^ ! | & ++ -- << >>\n sqrt() abs() log() ln() ^ %\n floor() ceil() round() rcpl()\n fact() pct() pert() comb()\n hcf() lcm() max() min() avg()\n sin() cos() tan() cosec() sec() cot()\n asin() acos() atan() acosec() asec() acot()\n sinh() cosh() tanh() cosechh() sech() coth()\n bi_dec() dec_bi() dec_oct() oct_dec() cel_fah() fah_cel()\n mode quit\n");
       printf("\n");                     
       do
       {   
		char ch;
                flag=0,count=0;
	        printf("\nEnter a valid erpression:");
                printf("                                             mode = %d\n",m);  
                yyparse();

                if(flag==-1){
                   flag=0;
                   yyparse();
                }
                 	
       }while(1);

}

void yyerror(char *s)			
{      
       	   printf("\033[0;31m");
           printf("%s\n\033[0m",s);
           flag=1;
       
}



