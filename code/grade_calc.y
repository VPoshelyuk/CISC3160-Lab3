
%{
#include <stdio.h>
int yylex();
int save_single_activity_result(int location, int result);
void yyerror();
int regs[26];
int base;
%}
%start list
%token DIGIT LETTER OTHER_ACTIVITY TOTAL
%%   
list:   list LETTER ' ' expr '\n' 
        {   
            if(save_single_activity_result($2, $4) == 0)return 0;
        }
    |   list OTHER_ACTIVITY ' ' number '\n' 
        {
            if(save_single_activity_result($2, $4) == 0)return 0;
        }
    |   list TOTAL 
        {
            printf("Total: %d\n", regs[5]+regs[11]+regs[15]+regs[16]+regs[17]);
            printf("Terminating...\n");
            return 0;
        }
    |
    ;
expr:   DIGIT
        {
            if($1 > 5) {
                printf("The score for a single quiz, lab or reflection can't be greater than 5.\n");
                printf("Current total: %d\n", regs[5]+regs[11]+regs[15]+regs[16]+regs[17]);
                printf("Terminating...\n");
                return 0;
            }
        }
    |   expr ' ' expr
        {
            $$ = $1 + $3;
        }
    ;
number: DIGIT
        {
            $$ = $1;
            base = ($1==0) ? 8 : 10;
        }
    |   number DIGIT
        {
            $$ = base * $1 + $2;
        }
    ;
%%
int main()
{
    printf("Hello there!\n"
        "This is a super simple grade calculator for CISC3160\n"
        "It's not fully ready and I expect users to know what they are doing!\n"
        "You should be able to enter your grades for quizzes, labs, and reflections "
        "using the following format: Q|L|R point point ... point\n"
        "To enter your scores for professionalism and final use the following format: P|F single_score\n"
        "To see your final score type T followed by enter\n");
    return(yyparse());
}
int save_single_activity_result(int location, int result)
{
    regs[location] = result;
    if (location == 5) {
        if(result > 40){
            printf("Final score can't be greater than 40!\n");
            return 0;
        }
        printf("Final: %d/40\n", result);
    } else if (location == 11) {
        if(result > 20){
            printf("Labs score can't be greater than 20!\n");
            return 0;
        }
        printf("Labs: %d/20\n", result);
    } else if (location == 15) {
        if(result > 10){
            printf("Professionalism score can't be greater than 10!\n");
            return 0;
        }
        printf("Professionalism: %d/10\n", result);
    } else if (location == 16) {
        if(result > 15){
            printf("Quizes score can't be greater than 15!\n");
            return 0;
        }
        printf("Quizes: %d/15\n", result);
    } else if (location == 17) {
        if(result > 15){
            printf("Reflections score can't be greater than 15!\n");
            return 0;
        }
        printf("Reflections: %d/15\n", result);
    }
    printf("Running total: %d\n", regs[5]+regs[11]+regs[15]+regs[16]+regs[17]);
    return 1;
}
void yyerror(s)
char *s;
{
    fprintf(stderr, "%s\n",s);
}
int yywrap()
{
    return(1);
}