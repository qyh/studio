#include "qyh.h"
#include <fcntl.h>

void 
set_fl(int fd, int flags) /* flags are file status flags to turn on */
{
    int     val;
    if ((val = fcntl(fd, F_GETFL, 0)) < 0)
        err_sys("fcntl F_GETFL error");
    
    val |= flags; /* turn on flags */
    
    if (fcntl(fd, F_SETFL, val) < 0)
        err_sys("fcntl F_SETFL error");
    
}

int 
main(int argc, char ** argv)
{
    if (argc != 3) {
        err_sys("Usage: [file descriptor] [flags] ");
    }
    
    set_fl(atoi(argv[1]), atoi(argv[2]));
    exit(0);
}
