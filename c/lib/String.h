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
    struct _String * prev;
    struct _String * next;

}String, *pString;

typedef pString  chars;

void string_init(pString * p, size_t size);

void string_reallocate(pString * p, size_t size);

void string_free(pString * p);

int string_append(pString *p, const char * s);

void string_print(pString p);

/**
 * Description: Initialize chars and specified size.
 * Return: void
 * Parameter: chars *p
 * Parameter: size
 */
void chars_init(chars *p, size_t size);

/**
 * Description: reallocate memory for the chars 
 * Parameter: chars *p
 * Parameter: size_t size.
 * Return: void
 */
void chars_reallocate(chars *p, size_t size);

/**
 * Description: free chars memory specified by pointer p
 * Parameter: chars *p
 * Return: void
 */
void chars_free(chars *p);

/**
 * Description: append a string to chars .
 * Parameter: chars p.
 * Parameter: const char *s.
 * Return: 0 if success, -1 otherwise.
 */
int chars_append(chars p, const char * s);

/**
 * Description: append the specified length of string to chars
 * Parameter: chars p
 * Parameter: const char *s
 * Parameter: size_t size 
 */
int chars_nappend(chars p, const char * s, size_t size);

/**
 * Description: copies the string to p, including the terminating null byte('\0')
 * Parameter: chars p
 * Parameter: s
 * Return: 0 if success, otherwise -1
 */
int chars_cpy(chars p, const char * s);

/**
 * Description: similar to chars_cpy(), except that only 'size' byte are copied.
 * Parameter: chars p
 * Parameter: const chars s
 * Parameter: size
 * Return: 0 if success, -1 otherwise
 */
int chars_ncpy(chars p, const char *s, size_t size);

/**
 * Description: read all the contents of the file which pointed by stream to p
 * Parameter: p
 * Parameter: size
 * Parameter: stream
 * Return: pointer of char which pointed to the file's contents
 */
char * chars_fgets(chars p, size_t size, FILE *stream);

/**
 * Description: read only one line of file which opend by stream
 * Parameter: p
 * Parameter: stream
 * Return: return a pointer to the line
 */
char * chars_readline(chars p, FILE *stream);

/**
 * Description: insert str to p before the specified index
 * Parameter: p
 * Parameter: str
 * Parameter: index
 * Return: 0 if success, -1 otherwise
 */
int chars_insert(chars p, const char * str, size_t index);

/**
 * Description: similar to chars_insert(), but only size byte are inserted.
 * Parameter: p
 * Parameter: str
 * Parameter: index
 * Parameter: size
 * Return: 0 if success, -1 otherwise
 */
int chars_ninsert(chars p, const char * str, size_t index, size_t size);

/**
 * Description: clipping p, but size byte left, which begin at begin parameter 
 * Parameter: p
 * Parameter: begin
 * Parameter: size
 * Return: 0 if success, otherwise -1
 */
int chars_cut(chars p, size_t begin, size_t size);

int chars_split(chars s, chars *buf, const char * separator);

chars * chars_array(size_t size, size_t nmemb);

void chars_array_free(chars * s);


void chars_print(chars p);

#endif


