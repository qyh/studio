#include <stdio.h>
#include <stdlib.h>

int 
main(void)
{
    char buf[1024] = {0};
    int value = -1;
    while (1){
        fscanf(stdin, "%d", &value);
        switch (value) {
            case 1 ... 100:
                printf("1 ... 100\n");
                break;
            case 0:
                printf("thanks for use\n");
                break;
            default:
                printf("you enter %d\n", value);
                break;
        }
        if (value == 0) {
            break;
        }
    }
    exit(0);
}
