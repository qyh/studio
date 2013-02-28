#include "queue.h"
#include "qyh.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void queue_init(queue * q, size_t datasize) 
{
    (q) = (queue *)Malloc(sizeof(queue));
    (q)->data = Malloc(datasize);

    (q)->head = (q)->data;
    (q)->tail = (q)->data;

    (q)->data->prev = (void *)0;
    (q)->data->next = (void *)0;
}

void queue_free(queue * q)
{
    void * p = q->head;
    while (p->next != NULL) {
        void * tmp = p;
        p = p->next;
        free(tmp);
    }
    free(q->tail);
}

int main(void)
{
    queue q;
    queue_init(&q, sizeof(Integer));
    queue_free(&q);
    exit(0);
}
