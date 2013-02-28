#include "qyh.h"
#include <string.h>
int 
main(void)
{
    char s[] = "HEllo world you are welcome !";
    char *buf = calloc(1, 6);
    strcpy(buf, "first");
    
    if (sizeof(buf) <= strlen(s)) {
        buf = realloc(buf, strlen(s) + strlen(buf) + 1);
    }
    
    strncat(buf, s, sizeof(s));
    printf("%s\n", buf);
    free(buf);
    exit(EXIT_SUCCESS);
}
