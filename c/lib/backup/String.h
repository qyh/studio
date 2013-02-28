#ifndef _STRING_H___
#define _STRING_H___
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef MAXLINE
#define MAXLINE 4096
#endif

typedef struct _String{

    char * s;
    size_t length;
    size_t capacity;

}String, *pString;

typedef pString  chars;

void string_init(pString * p, size_t size);

void string_reallocate(pString * p, size_t size);

void string_free(pString * p);

int string_append(pString *p, const char * s);

void string_print(pString p);

void chars_init(chars *p, size_t size);

void chars_reallocate(chars *p, size_t size);

void chars_free(chars *p);

int chars_append(chars p, const char * s);

int chars_nappend(chars p, const char * s, size_t size);

int chars_cpy(chars p, const char * s);

int chars_ncpy(chars p, const char *s, size_t size);

char * chars_fgets(chars p, size_t size, FILE *stream);

int chars_insert(chars p, const char * str, size_t index);

int chars_ninsert(chars p, const char * str, size_t index, size_t size);

int chars_cut(chars p, size_t begin, size_t size);

void chars_print(chars p);

#endif


