#include "Stack.h"


void * stack_new(size_t element_size)
{
    pStack ptr = (pStack)calloc(1, sizeof(Stack));
    if (NULL == ptr){
        fprintf(stderr, "stack allocate error\n");
    }
    ptr->element_size = element_size;
    ptr->data = NULL;
    ptr->size = 0;
    ptr->capacity = 0;
    return ptr;
}

void stack_free(pStack ptr)
{
    free(ptr->data);
    ptr->size = 0;
    free(ptr);
}

bool stack_push(pStack ptr, void * value)
{
    if (ptr->data == NULL) {
        ptr->data = calloc(1, ptr->element_size);
        if (ptr->data == NULL) {
            exit(EXIT_FAILURE);
        }
        memcpy(ptr->data, (char*)value, ptr->element_size);
        ptr->size = 1;
    } else {
        if (ptr->capacity <= ptr->size){
            ptr->data = realloc(ptr->data, ptr->size * ptr->element_size + ptr->element_size);
            memcpy(ptr->data + ptr->element_size * ptr->size, (char *)value, ptr->element_size);
            ptr->size += 1;
            ptr->capacity += 1;
        } else {    
            memcpy(ptr->data + ptr->element_size * ptr->size, (char *)value, ptr->element_size);
            ptr->size += 1;
        }
    }
    return true;
}

void stack_pop(pStack ptr)
{
    ptr->size -= 1;
}

void * stack_top(pStack ptr)
{
    return ptr->data + ((ptr->size - 1) * ptr->element_size);
}

size_t stack_size(pStack ptr)
{
    return ptr->size;
}

/** 
 * Test 
 */
typedef struct _stu {
    int no;
    char name[20];
    char *addr;
}Student, *pStudent;

#if 0
int main(void)
{
    int value = 10, v = 11, i;
    Student s1 = {12, "student1", "addr1"},s2 = {13, "student2","a1"}, 
            s3 = {15, "stu3", "address3"}, *sptr;
    pStack ps = stack_new(sizeof(Student) + 20);
    pStack p = stack_new(sizeof(int));

    stack_push(p, &value);
    stack_push(p, &v);
    printf("%d\n", *((int*)stack_top(p)));
    stack_pop(p);
    printf("%d\n", *((int*)stack_top(p)));
    

    stack_push(ps, &s1);
    stack_push(ps, &s2);
    sptr = (pStudent)stack_top(ps);
    printf("no: %d, name: %s\n", sptr->no, sptr->addr);
    stack_pop(ps);
    stack_push(ps, &s3);
    sptr = (pStudent)stack_top(ps);
    printf("no: %d, name: %s\n", sptr->no, sptr->addr);
    stack_free(ps);

    for (i = 0; i < 100; i++) {
        stack_push(p, &i);
    }
    for (i = 0; i < 100; i++) {
        printf("%d ", *((int*)stack_top(p)));
        stack_pop(p);
    }
    stack_free(p);
    exit(EXIT_SUCCESS);
}
#endif

