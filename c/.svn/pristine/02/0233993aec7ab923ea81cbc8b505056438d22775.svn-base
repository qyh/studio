#ifndef _VECTOR_
#define _VECTOR_

#include <string.h>
#include <strings.h>
#include "Stack.h"

#ifndef _BOOL_
#define _BOOL_

#if __STDC_VERSION__ >= 199901L
	#include <stdbool.h>
	#define C99
#else
	typedef enum {false, true} bool;
#endif

#endif 

typedef int DataType;

struct _vector;

typedef struct _vector Vector;

typedef struct _vector * pVector;

void * vector_new( size_t size );

/**
 * Destory vector
 */
void vector_destory(pVector ptr);

typedef void (*VectorDestory)(pVector);

/**
 * Return the value at index of 'index'
 */
DataType vector_at(pVector ptr, size_t index);

typedef DataType (*At)(pVector, size_t);

/**
 * Push 
 */
void vector_push_back(pVector ptr, DataType val);

typedef void (*VectorPush)(pVector, DataType);

/**
 * Remove from vector
 */
DataType vector_remove(pVector ptr, size_t index);
typedef DataType (*VectorRemove)(pVector ptr, size_t index);

/**
 * Empty of not
 */
bool vector_isEmpty(pVector ptr);
typedef bool (*VectorEmpty)(pVector);

/**
 * Clear vector
 */
void vector_clear(pVector ptr);
typedef void (*VectorClear)(pVector);

typedef struct _vector{
    DataType *  data;
    size_t  length;
    size_t  capacity;
    At              at;
    VectorPush      push_back;
    VectorRemove    remove;
    VectorDestory   destory;
    VectorEmpty     isEmpty;
    VectorClear     clear;
}Vector;

void * vector_new(size_t size)
{
    pVector ptr = (pVector)calloc(1, sizeof(Vector));
    if (NULL == ptr){
        exit(EXIT_FAILURE);
    }
    ptr->data = (DataType *)calloc(size, sizeof(DataType));
    if (NULL == ptr->data) {
        exit(EXIT_FAILURE);
    }
    ptr->length = 0;
    ptr->capacity = size;
    /* initialize method */
    ptr->push_back = &vector_push_back;
    ptr->at = &vector_at;
    ptr->destory = &vector_destory;
    ptr->remove = &vector_remove;
    ptr->isEmpty = &vector_isEmpty;
    ptr->clear = &vector_clear;
}

void vector_destory(pVector ptr)
{
    free(ptr->data);
    free(ptr);
}

void vector_push_back(pVector ptr, DataType val)
{
    if (ptr->capacity <= ptr->length) {
        ptr->data = realloc(ptr->data, ptr->capacity * 2);
        ptr->capacity += ptr->capacity;
        
    }
    memcpy(ptr->data + ptr->length * sizeof(DataType), &val, sizeof(DataType));
    ptr->length += 1;
}

DataType vector_at(pVector ptr, size_t index)
{
    if (index >= 0 && index < ptr->length) 
        return ptr->data[index * sizeof(DataType)];
    else 
        return ptr->data[(index % ptr->length) * sizeof(DataType)];
}

DataType vector_remove(pVector ptr, size_t index)
{
    DataType *a = ptr->data;
    if (ptr->length == 0){
        fprintf(stderr, "vector is already empty\n");
        return (DataType)0;
    }
    index = index % ptr->length;
    DataType val = ptr->at(ptr, index);
    if (index == ptr->length - 1){
        ptr->length -= 1;
    } else {
        size_t step = ptr->length - index - 1, i = 0;
        for (i = 0; i < step; i++){
            memcpy(a + (index + i)*sizeof(DataType), a + (index + 1 + i) * sizeof(DataType), sizeof(DataType));
        }
        ptr->length -= 1;
    }
    return val;
}

bool vector_isEmpty(pVector ptr)
{
    return ptr->length == 0;
}

void vector_clear(pVector ptr)
{
    bzero(ptr->data, ptr->length * sizeof(DataType));
    ptr->length = 0;
}

#endif

int main(void)
{
    int i;
    pVector vector = vector_new(10);
    vector->push_back(vector, 12);
    vector->push_back(vector, 49);
    vector->push_back(vector, 98);
    printf("%d\n", vector->remove(vector, 0));
    printf("%d\n", vector->remove(vector, 0));
    printf("%d\n", vector->remove(vector, 0));
#if 1
    for (i = 0; i < 100; i++){
        vector->push_back(vector, i + 1);
    }
#if 1
    for (i = 0; i < 100; i++){
        printf("%d ", vector->remove(vector, 0));
    }
#endif
#endif
    vector->clear(vector);
    vector->destory(vector);
    exit(EXIT_SUCCESS);
}
