#include <stdarg.h>
#include <strings.h>
#include "qyh.h"
void * Malloc(size_t size) {

    void * p = calloc(1, (size == 0 ? 1 : size));
    if (p == NULL) {
        fprintf(stderr, "Memory allocate error\n");
        exit(EXIT_FAILURE);
    }
    /*printf("\nMemory allocate\n");*/
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

int find_one_bits( unsigned value )
{
    int ones;
    for ( ones = 0; value != 0; value >>= 1 ) {
        if ( ( value & 1 ) != 0 ) {
            ones += 1;
        }
    }
    return ones;
}

int find_zero_bits( unsigned value )
{
    int ones;
    for ( ones = 0; value != 0; value >>= 1 ) {
        if ( ( value & 1 ) == 0 ) {
            ones += 1;
        }
    }
    return ones;
}
