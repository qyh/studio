#!/bin/sh 

param=$@
obj=""

while getopts ":o:" opt; do
    case $opt in 
        o ) obj=$OPTARG ;;
        * ) echo "Unknown options";
            exit 1 ;;
    esac
done
shift $(($OPTIND - 1))
param=$@
if [ "" = "$obj" ]; then
    obj=${1%.*}
fi

cat << !here! > Makefile.txt

CC=g++

INCLUDE=.

CFLAGS= -Wall -g

SRC = $param  

SOURCES := \${SRC}

OBJS := \$(SOURCES:.cpp=.o)

main:   \$(OBJS)
    \$(CC) \$(CFLAGS) -I\$(INCLUDE) -o \$@ \$(OBJS)

.cpp.o:	\$(SOURCES)
	\$(CC) \$(CFLAGS) -I\$(INCLUDE) -c \$<

.PHONY: clean

bin := $obj

clean:
	@rm -rf \$(OBJS) \$(bin) >/dev/null 2>&1

!here!

exit 0

