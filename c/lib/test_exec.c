/*extern size_t index_of_reverse(const char * src, const char * sub);*/
#include "qyh.h"

int main(int argc, char ** argv) {
    
    int i = 0;
    for (i = 1; i < argc; i++) {
        printf("%s ", argv[i]);
    }
    printf("\n");
    printf("%d\n",println("Hello new line %s %d", "line", 5));
    printf("%d\n",printf("Hello new line %s %d", "line", 5));
    exit(0);
}
