#include "studio.h"
#include <stdlib.h>

void * New(size_t size)
{
    if (size == 0) 
        return NULL;
    void * ptr = calloc(1, size);
    if (ptr == NULL){
        fprintf(stderr, "memory allocate error!\n");
        exit(EXIT_FAILURE);
    }
    return ptr;
}

void * Object(Constructor f)
{
    return f();
}

FILE * openfile(const char * filename, const char * mode)
{
    FILE * fp = fopen(filename, mode);
    if (fp == NULL){
        fprintf(stderr, "couldn't open file %s\n", filename);
        return NULL;
    }
    return fp;
}
