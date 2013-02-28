#ifndef __string_h
#define __string_h

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "../studio.h"

struct __string;
typedef struct __string String;

void * string_new(const char * str);
void * string_void(void);

void string_destory(String * str);
typedef void (*StringDestory)(String *);

const char * string_append(String * s, const char * str);
typedef const char * (*StringAppend)(String *, const char *);

const char * string_cpy(String * s, const char * str);
typedef const char * (*StringCpy)(String *, const char *);

const char * string_insert(String *s, const char * str, int);
typedef const char * (*StringInsert)(String *, const char *, int);

char string_at(String * , int index);
typedef char (*StringAt)(String *, int index);

const char * string_substr(String *, char * buf, int begin, int end);
typedef const char * (*StringSubStr)(String *, char *, int, int );

int string_find(String *, const char *);
typedef int (*StringFind)(String *, const char *);

int string_findAt(String *, const char *, int );
typedef int (*StringFindAt)(String *, const char *, int);

int string_cmp(String *, const char * str);
typedef int (*StringCmp)(String *, const char *);

const char * string_cstr(String *);
typedef const char * (*StringCstr)(String *);

const char * string_read(String * ptr, const char * filename);
typedef const char * (*StringRead)(String *, const char *);

const char * string_trim(String *);
typedef const char * (*StringTrim)(String *);

const char * string_ltrim(String *);
typedef const char *(*StringLtrim)(String *);

const char * string_rtrim(String *);
typedef const char *(*StringRtrim)(String *);

size_t string_separator(String *, const char * s);
typedef size_t (*StringSeparator)(String *, const char *);

char ** string_split(String *, const char *);
typedef char ** (*StringSplit)(String *, const char *);

const char * string_cut(String * , int begin, int end);
typedef const char * (*StringCut)(String *, int begin, int end);

const char * string_replace(String *, const char *, int begin, int end);
typedef const char * (*StringReplace)(String *, const char *, int, int);

bool string_startWith(String *, const char *);
typedef bool (*StringStartWith)(String *, const char *);

bool string_endWith(String *, const char *);
typedef bool (*StringEndWith)(String *, const char *);

const char * string_reverse(String *);
typedef const char * (*StringReverse)(String *);

const char * string_strip(String *);
typedef const char * (*StringStrip)(String *);

typedef struct __string {
    char * str;
    size_t length;
    size_t capacity;
    struct {
        char ** s;
        size_t * iters;
        size_t count;
    } ss;  
    StringDestory destory;
    StringAppend  append;
    StringCpy     copy;
    StringCmp     compare;
    StringInsert  insert;
    StringSubStr  substr;
    StringFind    find;
    StringFindAt  findAt;
    StringAt      at;
    StringCstr    cstr;
    StringRead    read;
    StringStrip   strip;
    StringTrim    trim;
    StringLtrim   ltrim;
    StringRtrim   rtrim;
    StringSeparator separator;
    StringSplit   split;
    StringCut     cut;
    StringReplace replace;
    StringStartWith startWith;
    StringEndWith   endWith;
    StringReverse   reverse;
}String;

#endif
