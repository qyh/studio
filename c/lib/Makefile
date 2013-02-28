# Target files
all:	libqyh.h config read_data_test dos2unix String_main dos2unix unix2dos test signal blocksize stat_example clean semap

# Which compiler
CC = gcc -std=c99
#CC = c99

# Options for development
#CFLAGS = -g -Wall -ansi
CFLAGS = -g  -ansi

# Where to include
INCLUDE = .

libqyh.a: apue.o qyh_string.o String.o qyh.o stack.o file.o daemonize.o semaphore.o
	ar r libqyh.a $^
#qyh.o:	qyh.c
#qyh_string.o:	qyh_string.c
#apue.o:	apue.c
#String.o:	qyh.c qyh_string.c apue.c 

..c.o:	
	$(CC) -c $<

test:	test.c libqyh.a
	$(CC) -o $@ $^

semap:	semap.o libqyh.a
	$(CC) -o $@ $^

String_main:	String_main.o libqyh.a


dos2unix:	dos2unix.o libqyh.a
	$(CC) -o $@ $^
#dos2unix.o: dos2unix.c String.c String.h qyh.h qyh_string.h apue.h qyh.c qyh_string.h

unix2dos:	unix2dos.o libqyh.a
	$(CC) -o $@ $^

signal:	signal.o libqyh.a
	$(CC) -o $@ $^

blocksize:	blocksize.o libqyh.a
	$(CC) -o $@ $^

stat_example:	stat_example.o libqyh.a
	$(CC) -o $@ $^

clean:	
	@rm ./*.o >/dev/null

#valgrind --leak-check=yes -v
#valgrind --leak-check=full --show-reachable=yes
