#include "qyh.h"
#include <setjmp.h>

jmp_buf jmpval;

int 
main(void)
{
    int i = 0;
    switch (setjmp(jmpval)) {
    case 0: 
        printf("first invoke setjmp()\n");
        break;
    case 1:
        printf("second invoke setjmp() use value 1\n");
        break;
    default:
        exit(EXIT_SUCCESS);
    }
    for (;;){
        longjmp(jmpval, ++i);
    }
    exit(EXIT_SUCCESS);
}
