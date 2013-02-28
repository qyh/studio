#include <stdarg.h>
#include <strings.h>
#include "qyh.h"
void * Malloc(size_t size) {
    void * p = malloc(size);
    if (p == NULL) {
        fprintf(stderr, "Memory allocate error\n");
        exit(EXIT_FAILURE);
    }
    return p;
}


int println(const char *fmt, ...)
{
    va_list     ap; 
    char        buf[MAXLINE + 2];
    int count = 0;
    va_start(ap, fmt);
    vsnprintf(buf, MAXLINE, fmt, ap);
    strncat(buf, "\n\0", 2);
    count = printf(buf);
    va_end(ap);
    return count;
}
