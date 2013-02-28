#include "map.h"
#include "../sort.h"
#include <string.h>
#include <strings.h>
#include "../studio.h"

static int MapNodeCmp(const void * lhs, const void * rhs);
static int map_search(Map * p, const char * value);
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
    int i = 0; 
    for ( ; i < p->length; i++){
        (p->data + i)->key->destory((p->data + i)->key);
        (p->data + i)->value->destory((p->data + i)->value);
    }
    free(p->data);
    free(p);
}

/**
 * search for key
 */

int map_search(Map * p, const char * key)
{
    int i = 0, iret = -1;
    while (i++ < p->length){
        iret = strcmp((p->data + i)->key->str, key);
        if (iret == 0)
            break;
    }
    if (i < p->length && iret == 0)
        return i;
    else
        return -1;
#if 0
    size_t max = p->length, min =0, mid;
    int iret = -1;
    while (min < max){
        mid = (min + max) / 2;
        iret = strncmp((p->data + mid)->key->str, key, strlen(key));
        if (iret == 0) {
            return mid;
        } else if (iret < 0){
            min = mid + 1;
        } else {
            max = mid - 1;
        }
    }
    return -1;
#endif
}

/**
 * Put key and value to map 
 */
void map_put(Map * ptr, const char * key, const char * value)
{
    if (key == NULL || value == NULL)
        return;
    /* search for key */
#if 1
    if (ptr->length != 0){
        MapNode * keyNode = (MapNode *)New(sizeof(MapNode));
        keyNode->key = string_new(key);
        printf("search..%s\n", key);
        int iret = binary_search(ptr->data, ptr->length, keyNode,
            sizeof(MapNode), &MapNodeCmp);
        /*int iret = map_search(ptr, key);*/
        printf("search..end %d\n", iret);
        if (iret != -1) {
            printf("copy..\n");
            (ptr->data + iret)->value->copy((ptr->data + iret)->value, value);
            printf("copy..end\n");
            keyNode->key->destory(keyNode->key);
            free(keyNode);
            return;
        } 
        keyNode->key->destory(keyNode->key);
        free(keyNode);
    }
#endif
    /* put into map */
    if (ptr->length >= ptr->capacity) {
        ptr->data = (MapNode *)realloc(ptr->data, sizeof(MapNode) * ((ptr->capacity + 1) * 2));
        ptr->capacity = (ptr->capacity + 1) * 2;
    }
    (ptr->data + ptr->length)->key = string_new(key);
    (ptr->data + ptr->length)->value = string_new(value);
    ptr->length += 1;
    shell_sort(ptr->data, ptr->length, sizeof(MapNode), &MapNodeCmp);
}

/**
 * Map comparator
 */
int MapNodeCmp(const void * lhs, const void * rhs)
{
    const MapNode *l = (const MapNode *)lhs;
    const MapNode *r = (const MapNode *)rhs;
    return l->key->compare(l->key, r->key->str);
}

/**
 * Get value from map specified by key 
 * return MapNode
 */
const char * map_get(Map * ptr, const char * key)
{
#if 1
    if (ptr->length == 0) 
        return NULL;

    MapNode * keyNode = (MapNode *)New(sizeof(MapNode));
    keyNode->key = string_new(key);
    int index = binary_search(ptr->data, ptr->length, keyNode, sizeof(MapNode), MapNodeCmp);
    keyNode->key->destory(keyNode->key);
    free(keyNode);
    return index != -1 ? (ptr->data + index)->value->str : NULL;
#endif
}

/**
 * Removes the mapping for a key from this map if it is present
 */
void map_remove(Map * ptr, const char * key)
{
#if 1
    int index = -1;
    if (ptr->length == 0) {
        return;
    } else {
        /* search for key */
        MapNode * keyNode = (MapNode *)New(sizeof(MapNode));
        keyNode->key = string_new(key);
        index = binary_search(ptr->data, ptr->length, keyNode,
                sizeof(MapNode), &MapNodeCmp);

        /* realease temporay memory */
        keyNode->key->destory(keyNode->key);
        free(keyNode);
    }
    /* Not found */
    if (index == -1)
        return;
    /* found and remvoe from map */
    (ptr->data + index)->key->destory((ptr->data + index)->key);
    (ptr->data + index)->value->destory((ptr->data + index)->value);

    memcpy(ptr->data + index, ptr->data + index + 1, 
            sizeof(MapNode) * (ptr->length - index - 1));
    ptr->length -= 1;
#endif
}

/**
 * Removes all of the mappings from this map 
 */
void map_clear(Map * ptr)
{
#if 1
    int i = 0;
    for ( ; i < ptr->length; i++) {
        (ptr->data + i)->key->destory((ptr->data + i)->key);
        (ptr->data + i)->value->destory((ptr->data + i)->value);
    }
    bzero(ptr->data, sizeof(MapNode) * ptr->length);
    ptr->length = 0;
#endif
}

int main(void)
{
    int i;
    Map * p = Object(map_new);
#if 0
    p->put(p, "--", "hoho");
    p->put(p, "3", "hoho");
    p->put(p, "3", "hoho3");
    p->put(p, "4", "hohosdfsdfsdssdfsds");
#endif
    p->put(p, "hello", "world");
    p->put(p, "c", "花销");
    p->put(p, "12", "third");
    p->put(p, "12", "world");
    p->put(p, "cssds", "sdfsdworld");
    p->put(p, "cssdsdsd", "花销");
    p->put(p, "12sdsdsds", "third");
    p->put(p, "helle", "sdfsdworld");
    p->put(p, "--", "hoho");
    p->put(p, "3", "hoho");
    p->put(p, "3", "hoho3");
    p->put(p, "4", "hohosdfsdfsdssdfsds");
    p->put(p, "helledfsd", "sdfsdworld");
    p->put(p, "hellndfsd", "sdfsdworld");
    p->put(p, "hello", "world");
    printf("%s\n", p->get(p, "3") == NULL ? "" : "Got it");
    puts("");
    printf("length: %ld\n", p->length);
    for (i = 0; i < p->length; i++){
        printf("[%s, %s]\n", (p->data + i)->key->str, (p->data + i)->value->str);
    }
    String * s = string_new("hellohello");
    printf("%d\n", s->compare(s, "hellohellp"));
    s->destory(s);
    p->destory(p);
    exit(EXIT_SUCCESS);
}
