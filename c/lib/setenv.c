#include "qyh.h"

int 
main(int argc, char ** argv)
{
    if (argc != 3) 
        err_quit("usage: %s <name> <value>", argv[0]);
    if (setenv(argv[1], argv[2], 1) != 0)
        err_sys("setenv error");
    fputs(getenv(argv[1]), stdout);
    printf("\n");
    exit(EXIT_SUCCESS);
}
