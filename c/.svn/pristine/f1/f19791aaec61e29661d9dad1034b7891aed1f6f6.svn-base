#include "String.h"
#include "qyh.h"
extern size_t index_of(const char* src, const char *s);
#ifndef MAX_LINE 
#define MAX_LINE 1024


int unix2dos(const char *filename, const char * ofile);



int unix2dos(const char *ifile, const char * ofile) {

    FILE * is = NULL;
    FILE * os = NULL;
    char * buf = NULL;
    chars contents = NULL;
    if ((is = fopen(ifile, "r")) == NULL) {
        fprintf(stderr, "Open file %s error", ifile);
        return -1;
    }
    buf = (char *)Malloc(MAX_LINE);
    bzero(buf, MAX_LINE);
    chars_init(&contents, MAX_LINE);

    while (!feof(is)) {
        fgets(buf, MAX_LINE - 2, is);
        int index = 0;
        if ((index = index_of(buf, "\n")) != -1) {
            if (index + 2 <= MAX_LINE) {
                buf[index] = '\r';
                buf[index + 1] = '\n';
                buf[index + 2] = '\0';
            }
        }
        chars_append(contents, buf);
    }
    free(buf);
    fclose(is);
    
    if ((os = fopen(ofile, "w")) == NULL) {
        fprintf(stderr, "open output file %s error", ofile);
        return -1;
    }
    /*chars_print(contents);*/
    fputs(contents->s, os);
    chars_free(&contents);
    fclose(os);
    return 0;
}

int main(int argc, char ** argv) {
    if (argc == 2) {
        printf("Converting file %s ...", argv[1]);
        if (unix2dos(argv[1], argv[1]) == -1) {
            exit(EXIT_FAILURE);
        }
        printf("Done\n");
    } else if (argc == 3) { 
        printf("Converting file %s to %s ...", argv[1], argv[2]);
        if (unix2dos(argv[1], argv[2]) == -1) {
            exit(EXIT_FAILURE);
        }
        printf("Done\n");
    }
    
    exit(EXIT_SUCCESS);
}

#endif
