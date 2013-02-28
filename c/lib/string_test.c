/*extern size_t index_of_reverse(const char * src, const char * sub);*/
#include "qyh.h"

int
main() {
    chars ss = NULL;
    chars_init(&ss, 10);
    chars_append(ss, "Hello world wold hello");
    chars_print(ss);
    chars_free(&ss);
    exit(EXIT_SUCCESS);
}
