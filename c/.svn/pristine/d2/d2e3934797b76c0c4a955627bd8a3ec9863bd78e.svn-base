#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "String.h"

int main(void)
{
    String * s = string_new("--*~!@#$%^&*()_=<F9>hello world 1@");
    String * ss = string_new("world hello s");
    String * tmp = string_new("hello world tmp");

    printf("s: %s\n", s->str);
    printf("ss: %s\n", ss->str);
    printf("s: %s\n", s->reverse(s));
    printf("ss: %s\n", ss->reverse(ss));
    printf("strip:%s\n", ss->strip(ss));
    s->destory(s);
    ss->destory(ss);
    tmp->destory(tmp);
}
