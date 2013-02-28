#include "qyh.h"

int cmp(const void * first, const void * second)
{
    return *((int *)first) <= *((int *)second) ? 1 : 0; 
}

int main(void)
{
    int i;
    int buf[] = {14,6,78,7,9,8,5,45,32,11};
    int numb = sizeof(buf)/sizeof(int);
    
    for (i = 0; i < numb; i++) {
        printf("%d ", buf[i]);
    }
    println();
    qsort(buf, numb, sizeof(int), cmp);
    for (i = 0; i < numb; i++) {
        printf("%d ", buf[i]);
    }
    println();
    exit(0);
}
