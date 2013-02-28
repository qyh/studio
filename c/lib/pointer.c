#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void)
{
    int *p;
    void * vp;
    int val = 0;
    vp = &val;
    p = &val;
    printf("p:%d\n", *p);
    printf("vp:%d\n", *((int *)vp));
    printf("integer size:%d\n", sizeof(int));
    printf("pointer size:%d\n", sizeof(p));
    printf("void * size:%d\n", sizeof(vp));
    
    exit(0);
}
