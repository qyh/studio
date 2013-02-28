#include <stdio.h>

#ifndef __bintree_h
#define __bintree_h

struct _btnode;
typedef struct _btnode BtNode;


struct _bintree;
typedef struct _bintree Bintree;

/**
 * Compare function for the data store in tree
 */
typedef int (*Comparator)(const void * lhs, const void * rhs);

/* Create a new tree */
void * bt_create(size_t elementSize, Comparator cmp);

/* Insert value to tree */
void bt_insert(Bintree * ptr, const void * value);
typedef void (*BtInsert)(Bintree *, const void *);

/* Find value from tree */
void * bt_find(Bintree * ptr, const void * value);
typedef void * (*BtFind)(Bintree *, const void *);

/**
 * Delete node from tree 
 * return 0 if success, -1 otherwise
 */
int bt_remove(Bintree * ptr, const void * value);
typedef int (*BtRemove)(Bintree * , const void *);

/* Print tree */
typedef void (*Print)(const void *);
void bt_print(Bintree *, Print);
typedef void (*BtPrint)(Bintree *, Print);

/**
 * Destory tree and realease memory
 */
void bt_destory(Bintree *);
typedef void (*BtDestory)(Bintree *);

typedef struct _bintree {
    BtNode * root;
    size_t elementSize;

    Comparator  cmp;
    BtInsert    insert;
    BtDestory   destory;
    BtFind      find;
    BtRemove    remove;
    BtPrint     print;
}BT;

typedef struct _btnode{
    char * data;
    struct _btnode * left;
    struct _btnode * rigth;
}BTNODE;

#endif

