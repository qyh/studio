#include "file.h"
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>

#ifndef MAXLINE
#define MAXLINE 4096
#endif

size_t getlines(FILE *stream, size_t linesize)
{
    size_t line = 0;
    fpos_t pos;
    char *buf = (char *)Malloc(linesize);
    fgetpos(stream, &pos);
    rewind(stream);
    while (!feof(stream)) {
        fgets(buf, linesize, stream);
        line++;
        
    }
    fsetpos(stream, &pos);
    free(buf);
    return --line;
}
