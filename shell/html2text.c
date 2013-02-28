#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void invoke_process(const char* buf) {
    char *tmpptr = NULL;
    char tmpbuf[1024] = {0};
    size_t begin = 0, end = 1, i = 0;
    tmpptr = malloc(strlen(buf) + 1);
    if (tmpptr == NULL) {
        fprintf(stderr, "memory allocate error");
        exit (EXIT_FAILURE);
    }
    strncpy(tmpptr, buf, strlen(buf) + 1);
    
    /*printf("%s", tmpptr);*/
    for (i = 0; tmpptr[i] != '\0'; i++) {
        if (tmpptr[i] == '<') {
            begin = 1;
            end = 0;
        } else if (tmpptr[i] == '>') {
            end = 1;
            begin = 0;
        } else {
            if (end == 1 && begin == 0){
                printf("%c", tmpptr[i]);
            }
        }
    }
    free(tmpptr);
}

int main(int argc, char ** argv) {
		
	FILE *fp;
    size_t lines = 0;
    char buf[1024] = {0};
    
    if (argc != 2) {
	    fprintf(stderr, "usage %s filename", argv[0]);
        exit (EXIT_FAILURE);
	}
    if ((fp = fopen(argv[1], "r")) == NULL) {
        fprintf(stderr, "Open file %s error!", argv[1]);
        exit (EXIT_FAILURE);
    }
    
    while (!feof(fp)) {
        fgets(buf, 1024, fp);
        /*invoke_process(buf);*/
        lines++;
    }
    rewind(fp);
    
    while (--lines) {
        fgets(buf, 1024, fp);
        invoke_process(buf);
    }
    
    printf("lines: %u\n", lines);
    fclose(fp);
    exit (EXIT_SUCCESS);
}
