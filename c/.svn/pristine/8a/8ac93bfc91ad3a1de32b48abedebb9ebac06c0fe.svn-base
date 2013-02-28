/*extern size_t index_of_reverse(const char * src, const char * sub);*/
#include "qyh.h"
#include <pcre.h>
#include <stdio.h>


static int split(const char *str, char ** buf, const char *sep){
    int count = 0, i = 0;
    char buffer[2][10];
    while (str[i] != '\0') {
        index_of(str, sep);
        
    }
    return 0;
}

int main(int argc, char ** argv) {
  

    chars s = NULL;
    size_t count = 0;
    FILE *fp = fopen("test.c", "r");
    chars_init(&s, MAXLINE);
    /*while (!feof(fp)) {
        chars_readline(s, fp);
        count++;
        chars_append(s, "\n");
        chars_print(s);
    }*/
    chars_fgets(s, MAXLINE, fp);
    /*chars_readline(s, fp);
    chars_readline(s, fp);*/
    chars_print(s);
    printf("lines: %ld\n", file_getline(fp));
    chars_free(&s);
    fclose(fp);
    printf("realese: %d\n", PCRE_MAJOR);
#if 0
    ///*chars s[10] = {0};*/
    chars *s = chars_array(1024, 10); 
    FILE *fp = fopen("test.c", "r");
    for (int i = 0; i < 10; i++) {
        chars_readline(s[i], fp);
        chars_append(s[i], "\n");
    }

    
    for (int i = 0; i < 10; i++){
        chars_print(s[i]);
    }
    
    chars_array_free(s);
    fclose(fp);
#endif
#if 0
    chars s = NULL;
    chars_init(&s, 10);
    chars_append(s, "world hello");
    chars_print(s);
    chars_ncpy(s, "Hello world", 5);
    chars_append(s, " sdjfksd");
    if(chars_ninsert(s, "insert", 1, strlen("insert") + 1) != -1){
        
    }
    
    chars_print(s);
    chars_free(&s);
    printf("%ld %d\n", index_of_at("Hello Hello", "e", 5), 'A');
#endif
    exit(0);
}


