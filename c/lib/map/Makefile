# Target files
all:	map
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

map:	map.c ../kmp.c ../studio.c ../sort.c ../string/String.c 
	$(CC) -o $@ $^


#valgrind --leak-check=yes -v
#valgrind --leak-check=full --show-reachable=yes
