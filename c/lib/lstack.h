/**
 * Stack interface
 */

/* The type which store in stack */
#define STACK_TYPE int

/**
 *  push
 */
void lstack_push( STACK_TYPE value );

/**
 *  pop
 */
void lstack_pop( void );

/**
 *  top
 */
STACK_TYPE lstack_top( void );

/**
 *  is_empty
 */
int lstack_is_empty( void );

/**
 *  is_full
 */
int lstack_is_full( void );

