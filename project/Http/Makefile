CC=g++

INCLUDE=.

DLL= pthread

CFLAGS= -Wall -g

SRC=chars.cpp httpclient.cpp httpserver.cpp image.cpp\
	logger.cpp main.cpp socket.cpp tcpclient.cpp tcpserver.cpp\
	tinythread.cpp tinyxml2.cpp utility.cpp

SOURCES := ${SRC}

OBJS := $(SOURCES:.cpp=.o)

main:	$(OBJS)
	$(CC) $(CFLAGS) -I$(INCLUDE) -o $@ $(OBJS) -l$(DLL)

.cpp.o:	$(SOURCES)
	$(CC) $(CFLAGS) -I$(INCLUDE) -c $<

.PHONY: clean

bin := main

clean:
	@rm -Rf $(OBJS) $(bin) >/dev/null 2>&1
