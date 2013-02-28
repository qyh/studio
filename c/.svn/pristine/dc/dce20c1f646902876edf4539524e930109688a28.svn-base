#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct linked_list {
    struct linked_list *next;
    char *data;
};

int 
main( int argc, char ** argv )
{
    struct linked_list *head = NULL;
    struct linked_list *tmp = NULL;
    char *test_string = "some data";
    int i = 0;

    for ( i = 0; i < 10; i++ ) {
        tmp = malloc(sizeof(*tmp));
        strncpy(tmp->data, test_string, strlen(test_string));
        tmp->next = head;
        head = tmp;
    }

    return 0;
}
