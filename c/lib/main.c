#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "qyh_string.h"

int main(int argc, char ** argv)
{
	char src[] = " Hello World! ";
	char s[] = "  aaa bbb  ";
	printf("%ld\n", index_of(src, "eo"));
	exit(EXIT_SUCCESS);
}

