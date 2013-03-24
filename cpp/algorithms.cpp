#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <string.h>
/**
 * 求一个整数的二进制表达式
 * 输入整数n并将其二进制形式写入buf
 * 如果buf为NULL则将二进制形式打印到
 * 标准输出.
 */
void decimalTobin(char * buf, const int n)
{
    int val = n;
    int q = 0;
    int r = 0;
    int i = 31;
    char tmp[33] = {0};
    memset(tmp, '0', 33);
    while (val)
    {
        r = val%2;
        val = val/2;
        tmp[i--] = r + '0';
    }
    tmp[32] = 0;

    if (buf != NULL && (strlen(buf) > 32))
    {
        memcpy(buf, tmp, 33);
    } 
    else 
    {
        printf("%s\n", tmp);
    }
}

/**
 * 比较两个整数比特位不同的数量
 */
int diffcount(int a, int b)
{
    int c = 0;
    int x = 0;
    for (x = (a^b); x != 0; x>>=1)
    {
        c += x&1;
    }
    return c;
}

/**
 * 打印杨辉三角
 * n表示要打印的行数
 */
void yanghui(const int n)
{
    for (int i = 0; i < n; i++)
    {
        for (int j = n-1-i; j > 0; j--)
        {
            printf("%c", 0x20);
        }
        for (int k = 0; k < (i+1)*2-1; k++) 
        {
            printf("%c", '*');
        }
        for (int j = n - 1 - i; j > 0; j--)
        {
            printf("%c", ' ');
        }
        printf("\n");
    }
}

/**
 * 交换两个数的值
 */
void swap(int * l, int * r)
{
#if 0
    *l += *r;
    *r = *l - *r;
    *l = *l - *r;
#endif
    *l ^= *r;
    *r ^= *l;
    *l ^= *r;
}

/**
 * 字符串反转
 */
char * reverse(char *str)
{
    int end = strlen(str) - 1;
    int start = 0;
    while (start < end)
    {
        str[start] ^= str[end];
        str[end] ^= str[start];
        str[start] ^= str[end];
        start++;
        end--;
    }
    return str;
}

/**
 * 计算某天是一年中的星期几
 */
int weekday(int year, int day)
{
    return (year-1) + ((year-1)/4) - ((year-1)/100) + ((year-1)/400) + day;
}

int main(int argc, char ** argv)
{
    decimalTobin(NULL, 4);
    decimalTobin(NULL, 5);
    printf("%d\n", diffcount(4, 5));
    //yanghui(5);
    int a = 10, b = 20;
    printf("a:%d, b:%d\n", a, b);
    swap(&a, &b);
    printf("a:%d, b:%d\n", a, b);

    char str[] = "Hello world";
    printf("%s\n", reverse(str));

    printf("%d\n", weekday(2013, 1));
    return 0;
}

