#include "semaphore.h"
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

int 
main(void) 
{
    pid_t   pid;
    int     sem_id;
    int     i;
    sem_id = semget((key_t)1234, 1, 0666 | IPC_CREAT);

    set_semvalue(sem_id);
    
    if ((pid = fork()) < 0) {
        fprintf(stderr, "fork error\n");
        exit(1);
    } 
    if (pid == 0) {
        for (i = 0; i < 10; i++) {
            semaphore_p(sem_id);
            sleep(1);
            printf("child...\n");
            semaphore_v(sem_id);
        }
        
    }
    for (i = 0; i < 10; i++) {
        semaphore_p(sem_id);
        sleep(1);
        printf("parent...\n");
        semaphore_v(sem_id);
    }
    waitpid(pid, (void*)0, WUNTRACED);

    exit(0);
}
