#include "Stack.h"
#include "Queue.h"

int main(void)
{
    int value = 10, v = 11, *ptr;
    const void * p;
    pStack stack = stack_new(sizeof(int));
    pQueue queue = queue_new(sizeof(int));
    stack_push(stack, &value);
    stack_push(stack, &v);
    queue_enqueue(queue, &value);
    queue_enqueue(queue, &v);

    ptr = (int*)stack_top(stack);
    printf("%d\n", *ptr);
    *ptr = 100;
    ptr = (int*)stack_top(stack);
    printf("%d\n", *ptr);

    stack_free(stack);
    queue_free(queue);
    exit(EXIT_SUCCESS);
}
