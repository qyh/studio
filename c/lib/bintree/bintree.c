#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include "../studio.h"
#include "bintree.h"

/* free tree (*node) */
static void btnodeDestory(BtNode *);

/* Create a new tree */
void * bt_create(size_t elementSize, Comparator cmp)
{
    Bintree * ptr = (Bintree *)New(sizeof(Bintree));
    ptr->root = NULL;
    ptr->cmp = cmp;
    ptr->elementSize = elementSize;
    ptr->insert = &bt_insert;
    ptr->destory = &bt_destory;
    ptr->find = &bt_find;
    ptr->remove =&bt_remove;
    ptr->print = &bt_print;
    return ptr;
}

/* Insert value to tree */
void btnodeInsert(BtNode ** ptr, const void * value,
        size_t elementSize, Comparator cmp)
{
    BtNode * root = *ptr;
    if ( root == NULL ){
        root = (BtNode *)New(sizeof(BtNode));
        root->data = (char *)New(elementSize);
        root->left = root->rigth = NULL;
        memmove(root->data, value, elementSize);
        *ptr = root;
        return;
    } else {
        if (cmp(value, root->data) < 0){
            btnodeInsert(&(*ptr)->left, value, elementSize, cmp);
        } else {
            btnodeInsert(&(*ptr)->rigth, value, elementSize, cmp);
        }
    }
}
void bt_insert(Bintree * ptr, const void * value)
{
   btnodeInsert(&ptr->root, value, ptr->elementSize, ptr->cmp); 
}

/**
 * Find value from tree
 * parameter: value or key
 * return the data of value specified
 */
static void * btFind(BtNode * node, const void * value, Comparator cmp)
{
    /* if null, return */
    if ((node) == NULL){
        return NULL;
    } else {
        if (cmp(value, (node)->data) == 0){
            return (node)->data;
        } else {
            if ( cmp(value, (node)->data) < 0){
                return btFind((node)->left, value, cmp);
            } else {
                return btFind((node)->rigth, value, cmp);
            }
        }
    }
}

void * bt_find(Bintree * ptr, const void * value)
{
    return btFind(ptr->root, value, ptr->cmp);
}

/**
 * Remove (*node) from tree 
 * return 0 if success, -1 otherwise
 */
static int btRemove(BtNode ** node, const void * value, Comparator cmp, size_t elementSize)
{
    BtNode * temp = (*node);
    if ((*node) == NULL){
        return -1;
    }
    if (cmp(value, (*node)->data) < 0){
        return btRemove(&(*node)->left, value, cmp, elementSize);
    } 
    if (cmp(value, (*node)->data) > 0){
        return btRemove(&(*node)->rigth, value, cmp, elementSize);
    }

    if ((*node)->left == NULL){
        (*node) = (*node)->rigth;
        free(temp);
        return 0;
    }

    if ((*node)->rigth == NULL){
        (*node) = (*node)->left;
        free(temp);
        return 0;
    } else {
        if ((*node)->left->rigth == NULL){
            (*node)->data = (*node)->left->data;
            return btRemove(&(*node)->left, (*node)->data, cmp, elementSize);
        } else {
            BtNode * p1 = (*node), *p2 = p1->left;
            while (p2->rigth != NULL){
                p1 = p2;
                p2 = p2->rigth;
            }
            memcpy((*node)->data, p2->data, elementSize);
            return btRemove(&p1->rigth, p2->data, cmp, elementSize);
        }
    }
}

int bt_remove(Bintree * ptr, const void * value)
{
    return btRemove(&(ptr->root), value, ptr->cmp, ptr->elementSize);
}


/**
 * Destory tree and realease memory
 */
void btnodeDestory(BtNode * (node))
{
    if ((node) != NULL) {
        btnodeDestory((node)->left);
        btnodeDestory((node)->rigth);
        free((node)->data);
        free((node));
        printf("free..\n");
    }
}
void bt_destory(Bintree * ptr)
{
    btnodeDestory(ptr->root);
}

/**
 * Print tree
 */
void printInt(const void * value)
{
    printf("%d\n", *((int *)(value)));
}
void btnodePrint(BtNode * (node), Print print)
{
    if ((node) != NULL){
        print((node)->data);
        if ((node)->left != NULL || (node)->rigth != NULL){
            printf("[");
            btnodePrint((node)->left, print);
            if ((node)->rigth != NULL) {
                printf(",");
            }
            btnodePrint((node)->rigth, print);
            printf("]");
        }
    }
}
void bt_print(Bintree * ptr, Print print)
{
    btnodePrint(ptr->root, print);
}

int intcmp(const void * dataPrev, const void * dataPost )
{
    const int *data1_int = ((const int*)dataPrev);
    const int *data2_int = ((const int*)dataPost);
    /*printf("%5d, %5d\n", *data1_int, *data2_int);*/
    return ((*data1_int) > (*data2_int)) - ((*data1_int) < (*data2_int));
}

int main(void)
{
    int value = 10, v = 12, i, *p;
    Bintree * bt = bt_create(sizeof(int), intcmp);
    for ( i = 0; i < 10; i++){
        bt->insert(bt, &i);
    }
    bt->insert(bt, &value);
    bt->insert(bt, &v);
    p = (int *)bt->find(bt, &value);
    printf("%d\n", *p);
    bt->remove(bt, &value);
    p = (int *)bt->find(bt, &value);
    if (p != NULL)
        printf("%d\n", *p);
    else
        printf("Not found\n");
    bt->print(bt, printInt);

    bt->destory(bt);
    exit(EXIT_SUCCESS);
}
