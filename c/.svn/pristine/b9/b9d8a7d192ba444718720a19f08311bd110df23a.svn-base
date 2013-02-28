/*
 * stack.h
 *
 *  Created on: 2011-10-7
 *      Author: Admin
 */

#ifndef STACK_H_
#define STACK_H_
#include <stdio.h>
#include <stdlib.h>
/* the data type of stack's data area in stack */

#ifndef _DATA_TYPE
#define _DATA_TYPE

typedef int Data;

#endif

typedef struct _stack{
	size_t length;		/* the length of stack */
	size_t capacity;	/* the capacity of stack */
	Data *data;			/* the data that contained in stack */
}Stack, *pStack;

/* initialize stack */
void stack_init(pStack* ptr, size_t size);

/* free stack */
void stack_destory(pStack* ptr);

/* add data to stack */
int stack_push(pStack ptr, Data val);

/* pop from the stack */
Data stack_pop(pStack ptr);

/* The top value of stack */
Data stack_top(pStack ptr);

/* return the size of stack */
int stack_size(pStack ptr);

void print_stack(pStack ptr, void (*f)(Data));

#endif /* STACK_H_ */



