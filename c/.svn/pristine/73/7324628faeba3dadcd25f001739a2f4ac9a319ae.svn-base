#ifndef _STACK_H
#define _STACK_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef _BOOL_
#define _BOOL_

#if __STDC_VERSION__ >= 199901L
	#include <stdbool.h>
	#define C99
#else
	typedef enum {false, true} bool;
#endif

#endif 

struct _stack;

typedef struct _stack Stack, *pStack;


/**
 * specified each element size which store in stack.
 * return stack pointer.
 */
void * stack_new(size_t element_size);

/**
 * Release stack memory
 */
void stack_free(pStack ptr);

/**
 * Push value into stack,
 */
bool stack_push(pStack ptr, void * value);

/**
 * Pop from stack
 */
void stack_pop(pStack ptr);

/**
 * Return the top element of stack
 */
void * stack_top(pStack ptr);

/**
 * Return stack size
 */
size_t stack_size(pStack ptr);

typedef void * (*Top)(pStack);

typedef void (*Pop)(pStack);

typedef bool (*Push)(pStack, void *);

typedef void (*Free)(pStack);

typedef struct _stack {
    size_t size;
    size_t capacity;
    char * data;
    size_t element_size;
    Top    top;
    Pop    pop;
    Push   push;
    Free   free;
}Stack, *pStack;


#endif

