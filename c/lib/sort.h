#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "studio.h"

#ifndef __sort_h
#define __sort_h


int integercompare(const void * dataPrev, const void * dataPost );
/**
 * Insert sort
 */
bool insert_sort(void * data, int length, int elementSize, int (*cmp)(const void *,const void *));

/**
 * Shell sort
 */
void shell_sort(void * data, int length, int elementSize, int (*cmp)(const void *,const void *));

/**
 * Bubble sort
 */
bool bubble_sort(void * data, int length, int elementSize, int (*cmp)(const void *,const void *));

/**
 * Select sort
 */
bool select_sort(void * data, int length, int elementSize, int (*cmp)(const void *,const void *));

/**
 * Binary search
 * param: 
 * return: the index of des index 
 */
int binary_search(void * data, int length, const void * des, size_t elementSize, int (*cmp)(const void *, const void *));

#endif 
