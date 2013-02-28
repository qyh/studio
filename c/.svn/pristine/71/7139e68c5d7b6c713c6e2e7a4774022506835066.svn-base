#ifndef __queue_h__
#define __queue_h__

#include <stdio.h>
#include <stdlib.h>

typedef struct _integer{
    int data;
    struct Integer * prev;
    struct Integer * next;
}Integer;

typedef struct _queue{
    void * head;
    void * tail;
    void * data;
}queue;


void queue_init(queue * q, size_t datasize);

void queue_free(queue * q);

#endif
