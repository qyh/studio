#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
int 
main(int argc, char ** argv)
{
    int     iret;
    if (argc != 2) {
        fprintf(stderr, "Usage %s filename", argv[0]);
        exit(1);
    }
    iret = access(argv[1], R_OK | W_OK);
    if (iret == 0) {
        printf("read and write permission\n");
    } else if (iret == -1) {
        fprintf(stderr, "read write not permitted error: %s\n", strerror(errno));
        
    }
    exit(EXIT_SUCCESS);
}
