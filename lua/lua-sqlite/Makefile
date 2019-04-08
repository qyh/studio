.PHONY: all clean install test
# Target files
all:	SQLITE_SO	
# Which compiler
CC = gcc -std=c99
#CC = c99
CFLAGS = -fPIC -shared
LIBS = -llua -lsqlite3

# Options for development
#CFLAGS = -g -Wall -ansi

SQLITE_SO := sqlite.so

..c.o:	
	$(CC) -c $<

SQLITE_SO:	lua-sqlite.c	
	$(CC) $(CFLAGS)	-o $(SQLITE_SO) $^ $(LIBS)

clean :
	-rm -rf $(SQLITE_SO) 
