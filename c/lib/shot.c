#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main( int argc, char **argv )
{
    char arg0[256] = {0};

    if ( argc < 2 ) {
        strncat(arg0, "-a", 3);
    } else if ( argc > 2 ) {
        fprintf(stderr, "usage: %s argument\n", argv[0]);
        exit(1);
    } else {
        strncat(arg0, argv[1], strlen(argv[1]));
    }

    if ( execl( "/usr/bin/gnome-screenshot", "gnome-screenshot", 
                arg0, " &", ( char * )0 ) < 0 ) {
        fprintf(stderr, "execl error for gnome-screenshot %s &\n", arg0);
        exit(1);
    }

    exit( 0 );
}
