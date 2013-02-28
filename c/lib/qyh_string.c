#include "qyh_string.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

const char* trim(char *src){
	
	size_t length = strlen(src);	
	char* tmp_ptr = (char*)malloc(sizeof(char) * length + 1);
	size_t i = 0, k = 0;
	while (src[k] != '\0'){
	
		if (src[k] != ' '){
			tmp_ptr[i++] = src[k];
		}
		k++;

	}	
	tmp_ptr[i] = '\0';
	strcpy(src, tmp_ptr);
	free(tmp_ptr);
	return src;		
}

const char* lstrip(char* src){

	/*size_t length = strlen(src);*/
	size_t i = 0;
	while (src[i] == ' '){
		i++;
	}

	strcpy(src, &src[i]);
	return src;
}

const char* rstrip(char* src){

	size_t length = strlen(src);
	size_t i = length;
	while (src[--i] == ' '){
		src[i] = '\0';
	}	
	return src;
}

const char* strip(char* src){

	rstrip(src);	
	lstrip(src);
	return src;
}

size_t index_of(const char* src, const char* separator){

	size_t i = 0, j = 0;
	size_t s_len = strlen(separator);
	int flag = 0;

	while (src[i] != '\0'){
		if (src[i] == separator[j]){
			i++;
			j++;
		} else {
			i = i - j + 1;
			j = 0;
		}
		
		if (j == s_len){
			flag = 1;
			break;
		}		
	
	}
	if (flag){
		return i - j;
	} else {
		return -1;
	}
}


size_t index_of_at(const char* src, const char* separator, size_t begin) {
    return index_of(src + begin, separator);
}

size_t index_of_reverse(const char* src, const char* separator){

    fprintf(stderr, "The function index_of_reverse is null implement\n");
    return -1;
}

