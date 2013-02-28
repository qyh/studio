/*
 * Stack.c
 *
 *  Created on: 2011-10-7
 *      Author: Admin
 */
#include "stack.h"
#include <stdio.h>


void stack_init(pStack* ptr, size_t size){

	*ptr = (pStack)malloc(sizeof(Stack));

	if ((*ptr) == NULL){
		exit(1);
	}

	(*ptr)->capacity = size;

	(*ptr)->data = (Data*)malloc( sizeof(Data) * ((*ptr)->capacity) );

	if ((*ptr)->data == NULL){
		exit(1);
	}

	(*ptr)->length = 0;
}

/* initialize stack */
void stack_destory(pStack* ptr){

	free((*ptr)->data);
	(*ptr)->data = NULL;
	free((*ptr));
	*ptr = NULL;
}

/* add data to stack */
int stack_push(pStack ptr, Data val){

	if (ptr->length >= ptr->capacity){
		return 0;
	}
	ptr->data[ptr->length] = val;
	ptr->length += 1;
	return 1;
}

/* pop from the stack */
Data stack_pop(pStack ptr){
	if (ptr->length <= 0){
		exit(1);
	}
	ptr->length -= 1;
	return ptr->data[ptr->length];
}

/* The top value of stack */
Data stack_top(pStack ptr){
	return ptr->data[ptr->length];
}

/* return the size of stack */
int stack_size(pStack ptr){
	return ptr->length;
}

void print_stack(pStack ptr, void (*f)(Data)){
	size_t i = 0;
	for (i = 0; i < ptr->length; i++){
		f(ptr->data[i]);
	}
	
}
