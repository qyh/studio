#include <stdio.h>
#include <stdlib.h>
int main()
{
        char s[80];
        int i;
        int isFirst = 1;
        int eatspace = 1;
        fgets(s, sizeof(s), stdin);
        for(i=0;i<80;i++)
        {
            while (s[i] == ' ' && eatspace) {
                i++;
            }
            eatspace = 0;
            if(s[i] > 'Z' && isFirst && s[i] != ' '){
                s[i]=s[i]-32;
                isFirst = 0; 
            }
            else if (s[i] == ' '){
                isFirst = 1;
            }
                
               /* if((s[i]<122&&s[i]>97)&&(s[i-1]<97||s[i-1]>122))
                s[i]=s[i]-32;*/
                
        }
        puts(s);
        return 0;
}
