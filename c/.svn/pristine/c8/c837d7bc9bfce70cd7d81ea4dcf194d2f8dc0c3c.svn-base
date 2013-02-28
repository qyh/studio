#include "qyh.h"
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>

int     glob = 6;

int 
main(void)
{
    int     var;
    pid_t   pid;
    
    var = 88;
    printf("before fork\n");
    
    if ((pid = vfork()) < 0) {
        err_sys("fork error");
    } else if (pid == 0) {
        glob++;
        var++;
        _exit(0);
    }
    
    printf("pid = %d, glob = %d, var = %d\n", getpid(), glob, var);
    exit(EXIT_SUCCESS);
}
