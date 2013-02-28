#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <strings.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

int 
main(int argc, char ** argv)
{
    int s, len;
    struct sockaddr_in remote_addr;
    char buf[BUFSIZ];
    
    if (argc != 2) {
        fprintf(stderr, "usage: %s server address\n", argv[0]);
        exit(1);
    }

    memset(&remote_addr, 0, sizeof(remote_addr));
    remote_addr.sin_family = AF_INET;
    remote_addr.sin_addr.s_addr = inet_addr(argv[1]);
    remote_addr.sin_port = htons(8000);

    if ((s = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket");
        return 1;
    }

    strcpy(buf, "this is a test message");
    printf("sending: '%s'\n", buf);
    if ((len = sendto(s, buf, strlen(buf), 0, (struct sockaddr *)&remote_addr, 
                    sizeof(struct sockaddr))) < 0) {
        perror("sendto");
        return 1;
    }

    close(s);
    exit(0);
}
