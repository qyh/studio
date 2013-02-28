#include <stdio.h>
#include <stdlib.h>

#ifndef __map_h
#define __map_h

#ifndef KeySize 
#define KeySize 512
#endif

#ifndef ValueSize
#define ValueSize 512
#endif 

/**
 * struct declare
 */
struct __map;
struct __mapnode;
typedef struct __mapnode MapNode;
typedef struct __map Map;

/* allocate memory for map */
void * map_new(void);

/* Destory map */
void map_destory(Map * ptr);
typedef void (*MapDestory)(Map *);

/**
 * Put key and value to map 
 */
void map_put(Map * ptr, const char * key, const char * value);
typedef void (*MapPut)(Map *, const char *, const char *);

/**
 * Get value from map specified by key 
 * return MapNode
 */
const char * map_get(Map * ptr, const char * key);
typedef const char * (*MapGet)(Map *, const char *);

/**
 * Removes the mapping for a key from this map if it is present
 */
void map_remove(Map * ptr, const char * key);
typedef void (*MapRemove)(Map * ptr, const char * key);

/**
 * Removes all of the mappings from this map 
 */
void map_clear(Map * ptr);
typedef void (*MapClear)(Map * ptr);

/**
 * struct definition
 */
typedef struct __mapnode{
    char key[KeySize];
    char value[ValueSize];
}MapNode;

typedef struct __map {
    MapNode * data;
    size_t length;
    size_t capacity;
    MapPut put;
    MapGet get;
    MapRemove remove;
    MapClear  clear;
    MapDestory destory;
}Map;

#endif
