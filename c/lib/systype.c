#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
#ifdef _LINUX
    printf("linux defined");
#endif
#ifdef _POSIX
    printf("unix defined");
#endif
#ifdef _WIN32
    printf("windows");
#endif
    exit(0);
}

