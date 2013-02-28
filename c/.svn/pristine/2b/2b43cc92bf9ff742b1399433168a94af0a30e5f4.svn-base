#include "lstack.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define     FALSE   0

/**
 * stack node
 */
typedef struct stack_node{

    STACK_TYPE  value;
    struct stack_node   *next;
} StackNode;

/**
 *  a pointer to the first node
 */
static StackNode *stack;

/**
 * Create stack
 */
void 
create_lstack( size_t size ){
}

/**
 * Destroy stack
 */
void
Destroy_lstack( void )
{
    while ( !lstack_is_empty() ) {
        lstack_pop();
    }
}

/**
 * push
 */
void 
lstack_push( STACK_TYPE value ) 
{
    StackNode   *new_node;
    new_node = calloc( 1, sizeof( StackNode ) );
    assert( new_node != NULL );
    new_node->value = value;
    new_node->next = stack;
    stack = new_node;
}

/**
 * pop
 */
void
lstack_pop()
{
    StackNode   *first_node;

    assert( !lstack_is_empty() );
    first_node = stack;
    stack = first_node->next;
    free( first_node );
}

/**
 * top
 */
STACK_TYPE top()
{
    assert( !lstack_is_empty() );
    return stack->value;
}

/**
 * is_empty
 */
int
lstack_is_empty( void )
{
    return stack == NULL;
}

/**
 * is_full
 */
int
lstack_is_full( void )
{
    return FALSE;
}

