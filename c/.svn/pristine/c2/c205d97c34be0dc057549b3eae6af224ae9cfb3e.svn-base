#include "config.h"
#include <stdlib.h>
#include <string.h>

int set_init(pSet *set_ptr){
	
	(*set_ptr) = (pSet)malloc(sizeof(Set));
	if (*set_ptr == NULL){	
		fprintf(stderr, "memory allocate error\n");
		exit(EXIT_FAILURE);
	}

	(*set_ptr)->pdata = (pSetData)malloc(sizeof(SetData) * 10);
	if ((*set_ptr)->pdata == NULL){
		fprintf(stderr, "memory allocate error\n");
		exit(EXIT_FAILURE);
	}
	(*set_ptr)->size = 0;
	(*set_ptr)->capacity = 10;
	return 1;
}

int set_add(pSet* set_ptr, Set s){
	if ((*set_ptr)->size < (*set_ptr)->capacity){
		(*set_ptr)->pdata[(*set_ptr)->size++] = s;
	} else {
		size_t size = (*set_ptr)->size;
		pSet *p = (pSet)malloc(sizeof(Set) * size);
		size_t i = 0;
		while (i < size){
			p->pdata[i] = (*set_ptr)->pdata[i];
			i++;
		}
		i = 0;
		while (i < size){
			free((*set_ptr)->pdata[i++]);
		}
		(*set_ptr)->pdata = (pSet)malloc(sizeof(Set) * size * 2);
		(*set_ptr)->capacity = size * 2;
		i = 0;
		while (i < size){
			(*set_ptr)->pdata[i] = p->pdata[i];
			i++;
		}
		(*set_ptr)->size = size;
		(*set_ptr)->pdata[(*set_ptr)->size++] = s;

	}
}

void insert_sort(char* src[MAX_LEN], size_t size){
	
	size_t i, j;
	char tmp[MAX_LEN];


	for (i = 1; i < size; i++){
		strcpy(tmp, src[i]);
		j = i - 1;
		
		while (j >= 0 && (strcmp(tmp, src[j]) < 0)){
			strcpy(src[j + 1], src[j]);
			j--;
		}
		strcpy(src[j + 1], tmp);

	}
}

int search_str(const char**src, size_t size, const char* dest){
#if 0
	size_t max = size;
	size_t min = 0;
	size_t mid = (max + min)/2;
	int flag = 0;

	while (1){
		if (strcmp(src[mid], dest) == 0){
			flag = 1;
		}else if (strcmp(src[mid], dest) < 0){
			min = mid + 1;
			mid = (min + max)/2;
		}else {
			max = mid - 1;
			mid = (min + max)/2;
		}
	}

	if (flag){
		return mid;
	} else {
		return -1;
	}
#endif

}

int configuration(Config* config, char* filename){

	FILE * fp = NULL;
	if ((fp = fopen(filename, "r")) == NULL){
		fprintf(stderr, "Cant't not open file: %s\n", filename);
	}

	return 1;
}

int compare(const void* a, const void *b){

	return strcmp((char*)a, (char*)b) < 0 ? 1:-1;
}

int main()
{
	char** ptr = DB_CONFIG;
	char** ptr2 = DB_CONFIG;
	while (*ptr){
		printf("%s\n", *ptr);
		ptr++;
	}
	while (*ptr2){
		printf("%s\n", *ptr2);
		ptr2++;
	}

    return 0;
}


