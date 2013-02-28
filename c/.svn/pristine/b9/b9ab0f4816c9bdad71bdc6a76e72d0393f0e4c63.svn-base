#include <stdio.h>
#include <strings.h>
#include "String.h"
#include "qyh.h"


void string_init(pString * p, size_t size) {
    (*p) = (pString)Malloc(sizeof(String));
    (*p)->s =  (char *)Malloc(size);
    bzero((*p)->s, size);
    (*p)->length = 0;
    (*p)->capacity = size;
}

void chars_init(chars *p, size_t size) {
    (*p) = (pString)Malloc(sizeof(String));
    (*p)->s =  (char *)Malloc(size);
    bzero((*p)->s, size);
    (*p)->length = 0;
    (*p)->capacity = size;
}

void string_free(pString * p) {
    free((*p)->s);
    (*p)->s = NULL;
    free(*p);
    *p = NULL;
}

void chars_free(chars *p) {
    free((*p)->s);
    (*p)->s = NULL;
    free(*p);
    *p = NULL;
}

void chars_reallocate(chars * p, size_t size) {
    
    char * buf = NULL;    
    if (size <= (*p)->capacity) {
        return;
    }
    buf = (char *)Malloc(size);
    bzero(buf, size);
    strncpy(buf, (*p)->s, (*p)->length);
    string_free(p);
    string_init(p, size);
    string_append(p, buf);
    free(buf);
    buf = NULL;
}
void string_reallocate(pString * p, size_t size) {
    
    char * buf = NULL;    
    if (size <= (*p)->capacity) {
        return;
    }
    buf = (char *)Malloc(size);
    bzero(buf, size);
    strncpy(buf, (*p)->s, (*p)->length);
    string_free(p);
    string_init(p, size);
    string_append(p, buf);
    free(buf);
    buf = NULL;
}

int string_append(pString *p, const char * s) {
    if ((*p)->capacity <= (strlen(s) + (*p)->length)) {
        string_reallocate(p, 2 * ((*p)->capacity + strlen(s)));
    }
    strncat((*p)->s, s, strlen(s));
    (*p)->length = (*p)->length + strlen(s);
    return 0;
}

int chars_append(chars p, const char * s) {
    size_t slen = strlen(s);
    if ((p)->capacity <= (slen + (p)->length)) {
       /* chars_reallocate(&p, 2 * ((p)->capacity + strlen(s)));*/
       /* char *buf = (char *)Malloc(p->length + 1);*/
        char *buf = p->s;
        memmove(buf, p->s, p->length + 1);
        p->capacity = (p->capacity + strlen(s)) * 2;
        p->s = (char *)Malloc(p->capacity);
        bzero(p->s, p->capacity);
        strncpy(p->s, buf, strlen(buf) + 1);
        free(buf);
    }
    strncat((p)->s, s, slen);
    (p)->length = p->length + strlen(s);
    return 0;
}

int chars_nappend(chars p, const char * s, size_t size) {
    int ret = 0;
    
    if (p->capacity <= (p->length + size)) {
        if (realloc(p->s, (p->capacity + size) * 2) == NULL) {
            fprintf(stderr, "memory allocate error\n");
            return -1;
        }
        p->capacity = (p->capacity + size) * 2;
    }
    strncat(p->s, s, size);
    p->length = p->length + size;
    return ret;
}

char * chars_fgets(chars p, size_t size,  FILE *stream) {
    char * buf = (char *)Malloc(MAXLINE);
    if (stream == NULL)
        return NULL;
    if (stream != stdin){
        size_t lines = getlines(stream, MAXLINE);
        while (lines--){
            fgets(buf, MAXLINE, stream);
            chars_append(p, buf);
        }
    } else {
        fgets(buf, MAXLINE, stream);
        chars_append(p, buf);
    }
    free(buf); 
    return p->s;
}

int chars_cpy(chars p, const char *s) {
    bzero(p->s, p->length);
    p->length = 0;
    return chars_append(p, s);
}

int chars_ncpy(chars p, const char *s, size_t size) {
    bzero(p->s, p->length);
    p->length = 0;
    return chars_nappend(p, s, size);
}

int chars_cut(chars p, size_t begin, size_t size) {
    char *s = (char *)Malloc(size + 1);
    size_t i = 0;
    if (begin < 0 || size < 0) {
        return -1;
    }
    for (i = begin; i < size + begin; i++) {
        s[i - begin] = p->s[i];
    }
    chars_ncpy(p, s, size);
    free(s);
    return 0;
}

int chars_insert(chars p, const char *str, size_t index) {
    
    chars prefix = NULL;
    chars suffix = NULL;
    
    if (index > p->length) {
        return chars_append(p, str);
    } else if (index < 0) {
        fprintf(stderr, "index must be elevatedzero range\n");
        return -1;
    }

    chars_init(&prefix, p->length + 1);
    chars_init(&suffix, p->length - index + 1);

    chars_nappend(prefix, p->s, index);
    chars_append(prefix, str);

    chars_cut(p, index, p->length - index);

    chars_nappend(suffix, p->s, p->length);

    chars_cpy(p, prefix->s);
    chars_append(p, suffix->s);

    chars_free(&prefix);
    chars_free(&suffix);
    return 0;
}

int chars_ninsert(chars p, const char *str, size_t index, size_t size) {
    
    int ret = 0;   
    char *buf = (char *)Malloc(size);
    strncpy(buf, str, size);
    ret = chars_insert(p, buf, index);
    free(buf);
    return ret;
}

void string_print(pString p) {
    printf("%s\nlength: %ld, capacity: %ld\n", (p)->s, (p)->length, (p)->capacity);
}

void chars_print(chars p) {
    printf("%s\nlength: %ld, capacity: %ld\n", (p)->s, (p)->length, (p)->capacity);
    /*printf("%s", (p)->s);*/
}
