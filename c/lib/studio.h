#ifndef _STUDIO_H
#define _STUDIO_H

#include <stdio.h>

#ifndef _BOOL_
#define _BOOL_

#if __STDC_VERSION__ >= 199901L
	#include <stdbool.h>
	#define C99
#else
	typedef enum {false, true} bool;
#endif

#endif /* end _BOOL_ */

#ifndef MAXLINE
#define MAXLINE 1024
#endif

void * New(size_t);

typedef void * (*Constructor)(void); 

void * Object(Constructor f);

FILE * openfile(const char * filename, const char * mode);

#endif /* end _STUDIO_H */
