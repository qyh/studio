#include "Queue.h"

/**
 * specified each element size which store in Queue 
 * return Queue pointer 
 */
void * queue_new(size_t element_size)
{
    pQueue ptr = (pQueue)calloc(1, sizeof(Queue));
    if (ptr == NULL) {
        fprintf(stderr, "queue allocate error \n");
        exit(EXIT_FAILURE);
    }
    ptr->front = NULL;
    ptr->rear = NULL;
    ptr->element_size = element_size;
    ptr->size = 0;
    return ptr;
}

/**
 * Release queue 
 */
void queue_free(pQueue ptr)
{
    queue_node *p = ptr->front;
    queue_node * q;
    while (p){
        q = p;
        p = p->next;
        free(q->data);
        free(q);
    }
    free(ptr);
}

/**
 * Enqueue
 */
bool queue_enqueue(pQueue ptr, void * value)
{
    queue_node *p = ptr->rear;
    queue_node *new_node = (queue_node *)calloc(1, sizeof(queue_node));
    if (new_node == NULL){
        fprintf(stderr, "queue_node allocate error\n");
        exit(EXIT_FAILURE);
    }
    new_node->data = (char *)calloc(1, ptr->element_size);
    if (new_node->data == NULL){
        exit(EXIT_FAILURE);
    }
    memcpy(new_node->data, (char *)value, ptr->element_size);
    new_node->next = NULL;

    /**
     * Insert into queue 
     */
    if (p == NULL) {
        /* If queue if empty */
        p = new_node;
        ptr->front = p;
        ptr->rear = p;
    } else {
        p->next = new_node;
        p = p->next;
        ptr->rear = p;
    }
    ptr->size += 1;
    return true;
}

/**
 * dequeue
 */
void queue_dequeue(pQueue ptr)
{
    queue_node *p = ptr->front;
    ptr->front = p->next;
    free(p->data);
    free(p);
    ptr->size -= 1;
}

/**
 * Queue front
 */
void * queue_front(pQueue ptr)
{
    return ptr->front->data;
}

/**
 * Queue rear 
 */
void * queue_rear(pQueue ptr)
{
    return ptr->rear->data;
}

/**
 * Queue size
 */
size_t queue_size(pQueue ptr)
{
    return ptr->size;
}
typedef struct _stu {
    int no;
    char name[20];
}Student;

#if 0
int main(void)
{
    Student s1 = {45, "hello"},
            s2 = {49, "world"}, * sptr;
    pQueue q = queue_new(sizeof(int));
    pQueue ps = queue_new(sizeof(Student));

    int value = 10, v = 12, *ip;
    queue_enqueue(q, &value);
    queue_enqueue(q, &v);
    ip = (int *)queue_front(q);
    printf("%d\n", *ip);
    queue_dequeue(q);
    ip = (int *)queue_front(q);
    printf("%d\n", *ip);
    queue_free(q);

    queue_enqueue(ps, &s1);
    queue_enqueue(ps, &s2);
    printf("queue size: %ld\n", queue_size(ps));
    sptr = (Student *)queue_front(ps);
    printf("no: %d, name: %s\n", sptr->no, sptr->name);
    queue_dequeue(ps);
    printf("queue size: %ld\n", queue_size(ps));
    sptr = (Student *)queue_front(ps);
    printf("no: %d, name: %s\n", sptr->no, sptr->name);
    queue_free(ps);
    exit(EXIT_SUCCESS);
}
#endif
