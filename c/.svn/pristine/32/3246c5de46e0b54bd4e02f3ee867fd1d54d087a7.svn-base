#include <string.h>
#include <strings.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int 
main(void) {
    char *dest = NULL;
    char *src = (char*)malloc(255);
    bzero(src, 255);
    strncpy(src, "Hello world", sizeof("Hello world"));
    dest = src;
    memmove(dest, src, sizeof("Hello world"));
    printf("src:%s\n", src);
    printf("dest: %s\n", dest);
    printf("free src...\n");
    free(src);
    strcpy(src, "sdjfksdfksdfjsdkfjskdfj");
    printf("src:%s\n", src);
    printf("dest: %s\n", dest);
    exit (EXIT_SUCCESS);
}
