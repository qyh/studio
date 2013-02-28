#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char ** f(char ** args)
{
    return args;
}

int main(int argc, char ** argv)
{
    char ** p = (char **)calloc(1, sizeof(char *) * 10);
    int i;
    for (i = 0; i < 10; i++){
        p[i] = (char *)calloc(1, 15 + i);
        memcpy(p[i], "hello world", strlen("hello world") + 1);
    }
    
    for (i = 0; i < 10; i++){
        if (p != NULL)
            printf("%s\n", p[i]);
        free(p[i]);
    }
    free(p);
    exit(EXIT_SUCCESS);
}
