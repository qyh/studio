#include "file.h"
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>
#include "String.h"

#ifndef MAXLINE
#define MAXLINE 4096
#endif

size_t file_getline(FILE *stream) {
    chars   s = NULL;
    size_t  lines = 0;
    fpos_t  pos;
    fgetpos(stream, &pos);
    rewind(stream);
    chars_init(&s, MAXLINE);
    while (!feof(stream)) {
        chars_readline(s, stream);
        lines++;
    }
    fsetpos(stream, &pos);
    chars_free(&s);
    return --lines;
}

size_t getlines(FILE *stream, size_t linesize)
{
    return 0;
}
