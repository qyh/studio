# Target files
all:	bintree
# Which compiler
CC = gcc -std=c99
#CC = c99

# Options for development
#CFLAGS = -g -Wall -ansi
CFLAGS = -g  -ansi

# Where to include
INCLUDE = .


..c.o:	
	$(CC) -c $<

bintree:	bintree.c ../kmp.c ../studio.c ../sort.c 
	$(CC) -o $@ $^


#valgrind --leak-check=yes -v
#valgrind --leak-check=full --show-reachable=yes
