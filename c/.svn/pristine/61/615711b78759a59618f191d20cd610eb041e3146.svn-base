#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "qyh_string.h"

int main()
{
	FILE *fp = NULL;
	char buf[100];
	memset(buf, '\0', sizeof(buf));
	char *filename = "data";
	printf("buf:%s\n", buf);
	if ((fp = fopen(filename, "r")) == NULL){
		fprintf(stderr, "open file %s error\n", filename);
		exit(EXIT_FAILURE);
	}
	printf("before read data:\n");

	while (!feof(fp)){
		fgets(buf, 50, fp);
		if (buf[0] != '#'){
			printf("%ld: ", strlen(buf));
			printf("%s", buf);
		}

	}
	exit(EXIT_SUCCESS);
}
