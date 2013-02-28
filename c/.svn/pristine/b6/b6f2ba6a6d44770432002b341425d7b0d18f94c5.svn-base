#include "print.h"

int println(const char *fmt, ...)
{
    va_list ap;
#ifndef MAXLINE
#define MAXLINE 1024
    char buf[MAXLINE];
    va_start(ap, fmt);
    vsnprintf(buf,MAXLINE, fmt, ap);
    snprintf(buf + strlen(buf), MAXLINE - strlen(buf), "\n");
    printf("%s", buf);
    va_end(ap);
#endif
    return 0;
}
