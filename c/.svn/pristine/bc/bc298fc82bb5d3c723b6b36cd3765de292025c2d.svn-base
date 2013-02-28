#include "qyh.h"

static void my_exit1(void);
static void my_exit2(void);

int
main(void)
{
    if (atexit(my_exit2) != 0)
        err_sys("can't register my_exit2");
    if (atexit(my_exit1) != 0)
        err_sys("can't register my_exit1");
    if (atexit(my_exit1) != 0)
        err_sys("cant't register myexit1");

    fputs("main is done\n", stdout);
    exit(EXIT_SUCCESS);
}

static void my_exit1(void)
{
    fputs("first exit handle\n", stdout);
}


static void my_exit2(void)
{
    fputs("second exit handle\n", stdout);
}
