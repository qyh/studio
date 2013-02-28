#include "sort.h"
int binary_search(void * data, int length, const void * des, size_t elementSize, int (*cmp)(const void *, const void *)) 
{
    char *a = (char *)data;
    int iret = -1;
    int min = 0, max = length, mid;
    while ( min <= max ) {
        mid = (min + max) / 2;
        iret = cmp(a + mid * elementSize, des);
        if (iret == 0) {
            return mid;
        } else if (iret < 0) {
            min = mid + 1;
        } else {
            max = mid - 1;
        }
    }
    return -1;
}

void shell_sort(void * data, int length, int elementSize, int (*cmp)(const void *,const void *))
{
    int gap = 0, i, j;
    char * a = data;
    void * iter = calloc(1, elementSize);
    if (iter == NULL) {
        exit(EXIT_FAILURE);
    }
    while ( gap <= length ) {
        gap = gap * 3 + 1;
    }
    while (gap > 0) {
        for ( i = 0; i < length; i++){
            j = i - gap;
            memcpy(iter, a + i * elementSize, elementSize);
            while ( j >= 0 && cmp(a + j * elementSize, iter) > 0 ){
                memcpy(a + (j + gap) * elementSize, a + j * elementSize,
                        elementSize);
                j -= gap;
            }
            memcpy(a + (j + gap) * elementSize, iter, elementSize);
        }
        gap = (gap - 1)/3;
    }
    free(iter);
}

bool select_sort(void * data, int length, int elementSize, int (*cmp)(const void *, const void *))
{
    char *a = data;
    void *iter;
    
	int i, j, flag;
    
    if((iter = (char *)malloc(elementSize)) == NULL)
        return false;
    
    if(data == NULL )
        return false;

    for ( i = 0; i < length - 1; i++ ) {
        memcpy(iter, a + i * elementSize, elementSize);
        flag = i;
        for ( j = i + 1; j < length; j++ ) {
            if (cmp(a + j * elementSize, iter) < 0) {
                memcpy(iter, a + j * elementSize, elementSize);
                flag = j;
            }
        }
        if (flag != i) {
            memcpy(a + flag * elementSize, a + i * elementSize, elementSize);
            memcpy(a + i * elementSize, iter, elementSize);
        }
    }

    free(iter);
    return true;
}
bool bubble_sort(void * data, int length, int elementSize, int (*cmp)(const void *, const void *))
{
    char *a = data;
    void *iter;
    
	int i, j;
    
    if((iter = (char *)malloc(elementSize)) == NULL)
        return false;
    
    if(data == NULL )
        return false;

    for ( i = 0; i < length; i++ ) {
        for ( j = i + 1; j < length; j++ ) {
            if (cmp(data + j * elementSize, data + (j - 1) * elementSize) < 0) {
                memcpy(iter, a + (j - 1) * elementSize, elementSize);
                memcpy(a + (j - 1) * elementSize, a + j * elementSize, elementSize);
                memcpy(a + j * elementSize, iter, elementSize);
            }
        }
    }
    free(iter);
    return true;
}
bool insert_sort(void * data, int length, int elementSize, int (*cmp)(const void *, const void *))
{
    char *a = data;
    void *iter;
    
	int i , j;
    
    if((iter = (char *)malloc(elementSize)) == NULL)
        return false;
    
    if(data == NULL )
        return false;
    
    for( i = 1; i < length; i++ ) {
        memcpy(iter,  a + i * elementSize , elementSize);
        j = i -1;
        
        while(j >= 0 && cmp(data + j * elementSize , iter) > 0){
            
            memcpy(a + (j + 1) * elementSize, a + j * elementSize , elementSize);
            j--;
        }
        
        if(j != (i - 1))
            memcpy(a + (j + 1) * elementSize, iter, elementSize);
    }
    free(iter);
    return true;
}
#define repr_array(arr,  len) {\
		int i = 0;\
			fprintf(stdout, "Array :[");\
			for(; i < len-1 ; i++){\
				fprintf(stdout, " %03d,", arr[i] );\
			}\
		fprintf(stdout, "%03d ]\n", arr[i] );}
			
int integercompare(const void * dataPrev, const void * dataPost )
{
    const int *data1_int = ((const int*)dataPrev);
    const int *data2_int = ((const int*)dataPost);
    /*printf("%5d, %5d\n", *data1_int, *data2_int);*/
    return ((*data1_int) > (*data2_int)) - ((*data1_int) < (*data2_int));
}

#if 0
int main (int argc, const char * argv[])
{
    /* insert code here...*/
    int arr[10] = {10, 5, 23, 56, 34, 78, 68, 54, 37, 98};
    int *p = arr; 
    int iret = -1;
    int des = 34;
    puts("Before sort:");
	repr_array(arr, 10);
    
	
    /*bubble_sort(p, 10, sizeof(int),  &integercompare);*/
    /*select_sort(p, 10, sizeof(int),  &integercompare);*/
    /*qsort(p, 10, sizeof(int),  &integercompare);*/
    shell_sort(p, 10, sizeof(int),  &integercompare);

    puts("After sort:");
    repr_array(arr, 10);
    iret = binary_search(p, 10, &des, sizeof(int), &integercompare);
    printf("iret is: %d\n", iret);
  
    return 0;
}





#endif
