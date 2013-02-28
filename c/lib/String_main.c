#include "String.h"
#include "qyh.h"
int main() {
    chars ss = NULL;
    size_t i = 0;
    chars_init(&ss, 10);
    chars_append(ss, "new chars append");
    for (i = 0; i < 1000; i++) {
        string_append(&ss, "new chars\n");
    }
    chars_print(ss);
    chars_free(&ss); 
    exit(EXIT_SUCCESS);
}

