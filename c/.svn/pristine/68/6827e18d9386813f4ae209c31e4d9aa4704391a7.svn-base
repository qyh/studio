#include "map.h"
#include "../sort.h"
#include <string.h>
#include <strings.h>
#include "../studio.h"

static int MapNodeCmp(const void * lhs, const void * rhs);

/* allocate memory for map */
void * map_new(void)
{
    Map * ptr = (Map *)New(sizeof(Map));
    ptr->data = (MapNode *)New(sizeof(MapNode));
    ptr->length = 0;
    ptr->capacity = 1;

    ptr->put = &map_put;
    ptr->get = &map_get;
    ptr->remove = &map_remove;
    ptr->clear = &map_clear;
    ptr->destory = &map_destory;
    return ptr;
}

/* Destory map */
void map_destory(Map * p)
{
    free(p->data);
    free(p);
}

/**
 * Put key and value to map 
 */
void map_put(Map * ptr, const char * key, const char * value)
{
    if (key == NULL || value == NULL)
        return;
    /* search for key */
    int iret = binary_search(ptr->data, ptr->length, key,
            sizeof(MapNode), &MapNodeCmp);
    if (iret != -1) {
        memcpy((ptr->data + iret)->value, value, ValueSize);
        return;
    }
    /* put into map */
    if (ptr->length >= ptr->capacity) {
        ptr->data = (MapNode *)realloc(ptr->data, sizeof(MapNode) * ((ptr->capacity + 1) * 2));
        ptr->capacity = (ptr->capacity + 1) * 2;
    }

    memcpy((ptr->data + ptr->length)->key, key, KeySize);
    memcpy((ptr->data + ptr->length)->value, value, ValueSize);
    ptr->length += 1;
    shell_sort(ptr->data, ptr->length, sizeof(MapNode), &MapNodeCmp);
}

/**
 * Map comparator
 */
int MapNodeCmp(const void * lhs, const void * rhs)
{
    MapNode *l = (MapNode *)lhs;
    MapNode *r = (MapNode *)rhs;
    return strncmp(l->key, r->key, KeySize);
}

/**
 * Get value from map specified by key 
 * return MapNode
 */
const char * map_get(Map * ptr, const char * key)
{
#if 1
    int index = binary_search(ptr->data, ptr->length, key, sizeof(MapNode), MapNodeCmp);
    return index != -1 ? (ptr->data + index)->value : NULL;
#endif 
}

/**
 * Removes the mapping for a key from this map if it is present
 */
void map_remove(Map * ptr, const char * key)
{
    int index = binary_search(ptr->data, ptr->length, key,
            sizeof(MapNode), &MapNodeCmp);
    if (index == -1)
        return;
    memcpy(ptr->data + index, ptr->data + index + 1, 
            sizeof(MapNode) * (ptr->length - index - 1));
    ptr->length -= 1;
}

/**
 * Removes all of the mappings from this map 
 */
void map_clear(Map * ptr)
{
    bzero(ptr->data, sizeof(MapNode) * ptr->length);
    ptr->length = 0;
}

int main(void)
{
    int i;
    Map * p = Object(map_new);
    p->put(p, "key", "value");
    p->put(p, "hello", "world");
    p->put(p, "c", "花销");
    p->put(p, "12", "third");
    for (i = 0; i < p->length; i++){
        printf("key: %s, value: %s\n", (p->data + i)->key, (p->data + i)->value);
    }
    printf("%s\n", "after sort..");
    
    p->remove(p, "key");
    p->clear(p);
    for (i = 0; i < p->length; i++){
        printf("[%s, %s]\n", (p->data + i)->key, (p->data + i)->value);
    }
    /*printf("%s\n", p->get(p, "12"));*/
    p->put(p, "--", "hoho");
    p->put(p, "3", "hoho");
    p->put(p, "3", "hoho3");
    p->put(p, "4", "hohosdfsdfsdssdfsds");
    for (i = 0; i < p->length; i++){
        printf("[%s, %s]\n", (p->data + i)->key, (p->data + i)->value);
    }
    p->destory(p);
    exit(EXIT_SUCCESS);
}
