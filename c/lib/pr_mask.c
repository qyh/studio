#include "qyh.h"
#include <errno.h>

void
pr_mask(const char * str)
{
    sigset_t    sigset;
    int         errno_save;

    errno_save = errno;

    if (sigprocmask(0, NULL, &sigset) < 0)
        err_sys("sigpromask error");
    
    printf("%s", str);
    if (sigismember(&sigset, SIGINT))   printf("SIGINT ");
    if (sigismember(&sigset, SIGQUIT))  printf("SIGQUIT ");
    if (sigismember(&sigset, SIGUSR1))  printf("SIGUSER1 ");
    if (sigismember(&sigset, SIGALRM))  printf("SIGALRM ");
    
    /* remaining signals can go here */
    printf("\n");
    errno = errno_save;
}

int
main(void)
{
    pr_mask("signal mask:");
    exit(0);
}
