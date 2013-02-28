#include "qyh.h"

#undef MAXLINE
#define MAXLINE 50

int
main(void)
{
    int fd1, fd2, err;
    char buf[MAXLINE] = {0};
    fd1 = open("test.c", FILE_MODE);
    read(fd1, buf, MAXLINE);
    printf("%s\n", buf);
    fd2 = dup(fd1);
    printf("fd: %d, %d\n", fd1, fd2);
    close(fd2);
    printf("============second read===========\n");
    bzero(buf, 50);
    err = read(fd1, buf, MAXLINE);
    printf("%s\n, error: %d\n", buf, err);
    close(fd1);
    exit(0);
}
