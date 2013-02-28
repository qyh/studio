#ifndef _semaphore_h_
#define _semaphore_h_

#ifndef _XOPEN_SOURCE
#define _XOPEN_SOURCE
#endif

#include <unistd.h>
#include <sys/sem.h>

#include "semun.h"

int set_semvalue(int sem_id);

void del_semvalue(int sem_id);

int semaphore_p(int sem_id);

int semaphore_v(int sem_id);

#endif
