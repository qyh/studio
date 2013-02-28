#include "String.h"
#include <strings.h>
#include "../kmp.h"
#include "../studio.h"

void * string_new(const char * str)
{
    size_t size = strlen(str) + 1;

    String * ptr = (String *)New(sizeof(String));
    ptr->str = (char *)New(size * sizeof(char));

    memcpy(ptr->str, str, strlen(str));
    ptr->str[size - 1] = 0;
    ptr->ss.s = NULL;
    ptr->ss.count = 0;
    /*strncpy(ptr->str, str, size - 1);*/
    ptr->length = size - 1;
    ptr->capacity = size;
    ptr->copy = &string_cpy;
    ptr->append = &string_append;
    ptr->compare = &string_cmp;
    ptr->insert = &string_insert;
    ptr->destory = &string_destory;
    ptr->substr = &string_substr;
    ptr->find = &string_find;
    ptr->findAt = &string_findAt;
    ptr->at = &string_at;
    ptr->cstr = &string_cstr;
    ptr->read = &string_read;
    ptr->strip = &string_strip;
    ptr->trim = &string_trim;
    ptr->ltrim = &string_ltrim;
    ptr->rtrim = &string_rtrim;
    ptr->separator = &string_separator;
    ptr->split = &string_split;
    ptr->cut = &string_cut;
    ptr->replace = &string_replace;
    ptr->startWith = &string_startWith;
    ptr->endWith = &string_endWith;
    ptr->reverse = &string_reverse;
    return ptr;
}

void * string_void(void)
{
    return string_new("");
}

const char * string_append(String * s, const char * str)
{
    if (s->capacity <= s->length + strlen(str)) {
        s->str = (char *)realloc(s->str, (s->length + strlen(str)) * 2);
        if (s->str == NULL){
            exit(EXIT_FAILURE);
        }
        s->capacity = (s->length + strlen(str)) * 2;
    }
    memcpy(s->str + s->length, str, strlen(str) + 1);
    s->length = s->length + strlen(str);
    return s->str;
}

const char * string_cpy(String * ptr, const char * str)
{
    if (ptr->capacity <= strlen(str))
    {
        ptr->str = (char *)realloc(ptr->str, strlen(str) + 1);
        ptr->capacity = strlen(str) + 1;
    }
    memcpy(ptr->str, str, strlen(str) + 1);
    ptr->length = strlen(str);
    return ptr->str;
}

const char * string_insert(String * ptr, const char * str, int index)
{
    index = index % (ptr->length + 1);
    if (index == 0){
        String *tmp = string_new(str);
        tmp->append(tmp, ptr->str);
        ptr->copy(ptr, tmp->str);
        tmp->destory(tmp);
    } else if (index == ptr->length) {
        ptr->append(ptr, str);
    } else {
        char *buf = (char *)calloc(1, ptr->length + strlen(str) + 1);
        memcpy(buf, ptr->str, index);
        strncat(buf, str, strlen(str));
        strncat(buf, ptr->str + index, ptr->length - index);
        ptr->copy(ptr, buf);
        free(buf);
    }
    return ptr->str;
}

const char * string_substr(String * ptr, char * buf, int begin, int end)
{
    if (begin < 0 || end >= ptr->length) {
        return NULL;
    }
    memcpy(buf, ptr->str + begin, end - begin);
    return buf;
}

int string_cmp(String *ptr, const char * str)
{
    size_t minlen = (ptr->length >= strlen(str) ? strlen(str) : ptr->length);
    return strncmp(ptr->str, str, minlen + 1);
}

int string_find(String * ptr, const char *p)
{
    if (strlen(p) == 0 || p == NULL) 
        return -1;
    return kmp(ptr->cstr(ptr), p);
}

int string_findAt(String * ptr, const char * p, int index)
{
    if (strlen(p) == 0 || p == NULL || index >= ptr->length) 
        return -1;
    int iret = kmp(ptr->str + index, p);
    return iret == -1 ? -1 : (index + iret);
}

char string_at(String * ptr, int index)
{
    index = index % (ptr->length);
    return ptr->str[index];
}

const char * string_cstr(String *ptr)
{
    return ptr->str;
}

void string_destory(String * ptr)
{
    free(ptr->str);
    ptr->length = 0;
    ptr->capacity = 0;
    ptr->str = NULL;
    if (ptr->ss.s != NULL){
        int i = 0;
        for ( ; i <= ptr->ss.count; i++ ){
            free(ptr->ss.s[i]);
        }
        free(ptr->ss.s);
    }
    free(ptr);
}

const char * string_read(String * ptr, const char * filename)
{
    FILE * fp = openfile(filename, "r");
    char *buf = (char *)New(MAXLINE);
    while (!feof(fp)){
        fgets(buf, MAXLINE, fp);
        if ( strlen(buf) != 0 ){
            ptr->append(ptr, buf);
        }
    }
    if (ptr->length > 0)
        ptr->str[--ptr->length] = 0;
    free(buf);
    fclose(fp);
    return ptr->cstr(ptr);
}

const char * string_ltrim(String * ptr)
{
    size_t iter = 0;
    while (ptr->str[iter] == ' '){
        iter++;
    }
    if (iter != 0){
        memmove(ptr->str, ptr->str + iter, ptr->length - iter + 1);
        ptr->length -= iter;
        /*ptr->str[ptr->length] = 0;*/
    }
    return ptr->str;
}

const char * string_rtrim(String * ptr) 
{
    size_t iter = ptr->length - 1;
    while ( ptr->str[iter] == ' ') {
        iter--;
    }
    if (iter != ptr->length - 1){
        bzero(ptr->str + iter, ptr->length - iter - 1);
        ptr->length = iter + 1;
    }
    return ptr->str;
}

const char * string_trim(String * ptr)
{
    ptr->ltrim(ptr);
    ptr->rtrim(ptr);
    return ptr->str;
}

size_t string_separator(String * ptr, const char * s)
{
    size_t count = 0;
    int iret = ptr->findAt(ptr, s, 0);
    while (iret != -1){
        iret = ptr->findAt(ptr, s, iret + 1);
        count++;
    }
    return count;
}

char ** string_split(String * ptr, const char * s)
{
    size_t count = 0;
    /* Save separator count */
    if ( (count = ptr->separator(ptr, s)) == 0 ){
        return NULL;
    }
    if (ptr->ss.s != NULL){
        int i;
        for (i = 0; i < ptr->ss.count; i++){
            free(ptr->ss.s[i]);
        }
        free(ptr->ss.s);
    }
    ptr->ss.count = count;

    /* Allocate memory for ptr->ss.s */
    ptr->ss.s = (char **)New(sizeof(char *) * (ptr->ss.count + 2));
    /* Set the last string to null */
    ptr->ss.s[count + 1] = NULL;
    long iret = 0, pre = 0, index = 0, iter = 0;

    /* get the first index of s */
    index = ptr->find(ptr, s);

    /* Allocate memory for the first string */
    ptr->ss.s[iter] = (char *)New(sizeof(char) * (index + 1));
    if (index != 0) {
        memcpy(ptr->ss.s[iter], ptr->str, index);
    }
    /*char ** a = ptr->ss.s;*/
    do {
        /* Save the previous index of s and get next */
        iter++;
        pre = index;
        index = ptr->findAt(ptr, s, pre + 1);
        /* Allocate memory for next string */
        if (iter < ptr->ss.count){
            ptr->ss.s[iter] = (char *)New(sizeof(char) * (index - pre + 1));
            if (index - pre - 1 != 0){
                memcpy(ptr->ss.s[iter], ptr->str + pre + 1, index - pre - 1);
            }
        }
    } while ( index != -1 );
    /* process the last string */
#if 1
    if (pre + 1 < ptr->length){
        ptr->ss.s[iter] = (char *)New(sizeof(char) * (ptr->length - pre + 1));
        memcpy(ptr->ss.s[iter], ptr->str + pre + 1, ptr->length - pre - 1);
    }
#endif
    return ptr->ss.s;
}

/**
 * Replace 
 */
const char * string_replace(String * ptr, const char * s, int begin, int end)
{
    ptr->cut(ptr, begin, end);
    ptr->insert(ptr, s, begin);
    return ptr->str;
}

/**
 * Cut
 */
const char * string_cut(String * ptr, int begin, int end)
{
    begin %= ptr->length, end %= ptr->length;
    memmove(ptr->str + begin, ptr->str + end + 1, ptr->length - end);
    return ptr->str;
}

/**
 * Start with
 */
bool string_startWith(String * ptr, const char * s)
{
    return strncmp(ptr->str, s, strlen(s)) == 0 ? true: false;
}

/**
 * End with s or not
 */
bool string_endWith(String * ptr, const char * s)
{
    return ptr->findAt(ptr, s, ptr->length - strlen(s)) == -1 ? false : true;
}

/**
 * Reverse
 */
const char * string_reverse(String * ptr)
{
    char * a = ptr->str;
    size_t length = ptr->length, begin, end;
    for (begin = 0, end = length - 1; end > begin; begin++, end--){
        a[begin] += a[end];
        a[end] = a[begin] - a[end];
        a[begin] = a[begin] - a[end];
    }
    return ptr->str;
}

/**
 * strip
 */
const char * string_strip(String * ptr)
{
    char * str = (char *)New(ptr->length + 1);
    int i = 0, k = 0;
    while ((ptr->str[i]) != '\0') {
        if (ptr->str[i] != ' ') {
            str[k++] = ptr->str[i];
        }
        i++;
    }
    str[k] = 0;
    ptr->copy(ptr, str);
    free(str);
    return ptr->str;
}
#if 0
int main(void)
{
#if 0
    char buf[100] = {0};
    printf("%s\n", s->str);
    s->append(s, "this is String struct !");
    printf("%s\n", s->str);
    s->copy(s, "Now is new one !");
    printf("%s\n", s->str);
    printf("%c\n", s->at(s,-1));
    s->insert(s, " begin", 0);
    printf("%s\n", s->str);
    s->insert(s, "mid", 5);
    printf("%s\n", s->str);
    s->insert(s, "end ", s->length);
    printf("%s\n", s->str);
    printf("%d\n", s->find(s, "end"));
    printf("%d\n", s->find(s, "mid"));
    printf("--%s--\n", s->cstr(s));
    s->read(s, "String.h");
    printf("--%s--\n", s->trim(s));
    printf("--%s--\n", s->trim(s));
#endif 
    /*String * s = string_new("hello world hello world");*/
    String *s = Object(string_void);
    s->append(s, "Hello wolr dsdk");
    printf("String's size: %ld\n", sizeof(s->ss.s));
    char ** p = NULL;
    printf("%ld,%s\n", s->length, s->cstr(s));
    printf("%d\n", s->findAt(s, "ld", 10));
    printf("%ld\n", s->separator(s, " "));
    p = s->split(s, " ");
    printf("count: %ld\n", s->ss.count);
    while (p != NULL && *p) {
        printf("%s\n", *(p++));
    }
    printf("%s\n", s->str);
    printf("%s\n", s->replace(s, "000", 0, 2));
    printf("%d\n", s->endWith(s, "ld"));
    s->split(s, " ");
    printf("world count: %ld\n", s->ss.count + 1);
    s->destory(s);
    exit(EXIT_SUCCESS);
}
#endif 
