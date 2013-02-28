#ifndef _QYH_LIB_ 
#define _QYH_LIB_

#include <stdio.h>
#include <stdlib.h>

/**
 * trim()
 * Cut the string, with any whitespace omitted. 
 */
const char* trim(char* src);

/**
 * lstrip()
 * Cut the string, with leading whitespace omitted.
 */
const char* lstrip(char* src);

/**
 * rstrip()
 * Cut the string, with trailing whitespace omitted.
 */
const char* rstrip(char* src);

/**
 * strip()
 * Cut the string, with leading and trailing whitespace ommited.
 */
const char* strip(char* src);

/**
 * indexOf()
 * Return the first index of the string of parameter specified found in 
 * source string. -1 if not found.
 */
size_t index_of(const char* src, const char* separator);

/**
 * index_of_reverse()
 * Return the first index of the string of parameter specified found in 
 * source string. -1 if not found.
 */

size_t index_of_reverse(const char* src, const char* separator);

/**
 * split
 */

#endif
