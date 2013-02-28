#include "qyh.h"

int main(void)
{
    FILE *fp = fopen("test.c", "r");
    if (fp == NULL)
        err_quit("opend file error");
    
    printf("lines: %ld\n", getlines(fp));
    exit(0);
}
