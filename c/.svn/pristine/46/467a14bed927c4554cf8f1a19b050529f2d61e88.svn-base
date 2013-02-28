#include "sort.h"
#define repr_array(arr,  len) {\
		int i = 0;\
			fprintf(stdout, "Array :[");\
			for(; i < len-1 ; i++){\
				fprintf(stdout, " %03d,", arr[i] );\
			}\
		fprintf(stdout, "%03d ]\n", arr[i] );}

#if 1
int main (int argc, const char * argv[])
{
    /* insert code here...*/
    int i = 0;
    int arr[10] = {10, 5, 23, 56, 34, 78, 68, 54, 37, 98};
    int *p = arr; 
    int iret = -1;
    int des = 23;
    puts("Before sort:");
	repr_array(arr, 10);
    
	
    /*bubble_sort(p, 10, sizeof(int),  &integercompare);*/
    /*select_sort(p, 10, sizeof(int),  &integercompare);*/
    /*qsort(p, 10, sizeof(int),  &integercompare);*/
    shell_sort(p, 10, sizeof(int),  &integercompare);

    puts("After sort:");
    repr_array(arr, 10);
    for (; i < 10; i++){
        des=p[i];
        iret = binary_search(p, 10, &des, sizeof(int), &integercompare);
        printf("searching %d, iret is: %d\n", des, iret);
    }
    return 0;
}





#endif
