#ifndef __TCPCLIENT_H
#define __TCPCLIENT_H

#include <string>
#include "socket.h"

using std::string;

class TCPClient : public Socket
{
public: 
	// Construct
	TCPClient();

	// Destruct
	~TCPClient();

	// @brief Connect to remote host
	// @param host The host name of server,
	// @param serv Server's name or port number
	// @return If no error occurs returns 0, Otherwise -1 is returns.
	int connect(const char *host, const char* serv);


protected:
	// Remote host name
	string m_host;
	// Remote port number
	string m_port;
private:
};

#endif

