#include "qyh.h"
#include <shadow.h>

int 
main(int argc, char *argv[])
{
    struct spwd *sp = NULL;
    if (argc != 2) {
        err_quit("usage: %s <username>", argv[0]);
    }
    if ((sp = getspnam(argv[1])) == NULL)
        err_quit("getspnam error");
    printf("Login name: %s\n", sp->sp_namp);
    printf("Encrypted password: %s\n", sp->sp_pwdp);    
    printf("Date of last change: %ld\n", sp->sp_lstchg);
    printf("Min of days between changes: %ld\n", sp->sp_min);
    printf("Max of days between changes: %ld\n", sp->sp_max);
    printf("Days before password expires: %ld\n", sp->sp_warn);
    printf("Days after password expires: %ld\n", sp->sp_inact);
    printf("Date when account expires: %ld\n", sp->sp_expire);
    exit(EXIT_SUCCESS);
}
