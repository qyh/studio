#include "lstack.h"
#include "qyh.h"
#include <stdio.h>
#include <stdlib.h>

int main( void )
{
    int i;
    println("is_empty: %d", lstack_is_empty());
    for ( i = 0; i < 10; i++ ) {
        lstack_push( i + 1 );
    }
    println("is_empty: %d", lstack_is_empty());
    for ( i = 0; i < 10; i++ ) {
        lstack_pop();
    }
    println("is_empty: %d", lstack_is_empty());
    exit(0);
}
