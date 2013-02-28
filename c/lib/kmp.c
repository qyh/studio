#include "kmp.h"

static void getNext(const char *, int *);

int kmp(const char * str, const char *p)
{
    int next[MAX_ARRAY] = {0};
    int i = 0, j = 0;
    getNext(p, next);
    
    while ( i < strlen(str) ){
        if ( j == -1 || str[i] == p[j] ) {
            i++;
            j++;
        } else {
            j = next[j];
        }

        if ( j == strlen(p) ) {
            return i - strlen(p);
        }
    }

    return -1;
}

void getNext(const char *p, int *next)
{
    int j = 0, k = -1;
    next[0] = -1;
    while ( j < strlen(p) - 1 ){
        if ( k == -1 || p[j] == p[k] ){
            j++;
            k++;
            next[j] = k;
        } else {
            k = next[k];
        }
    }
}
#if 0
int main(void)
{
    printf("%d\n", kmp("hello world", "or"));
    exit(EXIT_SUCCESS);
}
#endif
