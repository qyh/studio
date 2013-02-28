#include "qyh.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char ** argv)
{
    struct stat s;
    fstat(STDIN_FILENO, &s);
    printf("best IO blck size %ld\n", s.st_blksize);
    printf("number of disk blocks allocated %ld\n", s.st_blocks);
    exit(EXIT_SUCCESS);
}
