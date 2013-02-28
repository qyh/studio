#ifndef _QUEUE_H
#define _QUEUE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef _BOOL_
#define _BOOL_

#if __STDC_VERSION__ >= 199901L
    #include <stdbool>
    #define C99 
#else
    typedef enum {true, false} bool;
#endif

#endif

typedef struct q_node{
    char * data;
    struct q_node *next;
}queue_node;

typedef struct _queue {
    size_t size;
    queue_node *front;
    queue_node *rear;
    size_t element_size;
}Queue, *pQueue;

/**
 * specified each element size which store in Queue 
 * return Queue pointer 
 */
void * queue_new(size_t element_size);

/**
 * Release queue 
 */
void queue_free(pQueue ptr);

/**
 * Enqueue
 */
bool queue_enqueue(pQueue ptr, void * value);

/**
 * dequeue
 */
void queue_dequeue(pQueue ptr);

/**
 * Queue front
 */
void * queue_front(pQueue ptr);

/**
 * Queue rear 
 */
void * queue_rear(pQueue ptr);

/**
 * Queue size
 */
size_t queue_size(pQueue ptr);
#endif
