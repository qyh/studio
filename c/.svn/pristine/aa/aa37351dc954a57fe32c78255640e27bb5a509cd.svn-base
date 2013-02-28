#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

int
main(int argc, char **argv)
{
    char *sc = "short characters";
    wchar_t *wc = L"wider characters";

    printf("%ls are more universally useful than %s, ",
            wc, sc);

    printf("but they do use more space (%d as opposed to %d bytes).\n",
            wcslen(wc)*sizeof(wchar_t), strlen(sc));

    exit(0);

}
