#ifndef __QLIB_HTTP_H
#define __QLIB_HTTP_H

#ifdef _WIN32
#include <WinSock2.h>
#include <io.h>
#include <Ws2tcpip.h>
#pragma warning(disable:4996)
#define snprintf _snprintf
#else
#include <fcntl.h>
#include <sys/stat.h>
#include <signal.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#define SOCKET int
#define INVALID_SOCKET -1
#endif

#include <cstdio>
#include <string>
#include <map>
#include "chars.h"

using std::string;
using std::map;

class HTTP 
{

public:
	// Constructor and destructor
	HTTP();
	~HTTP();
	// @brief Open a connect 
	// @param string url an address to be open
	// @return 0 if success otherwise -1
	int open(const std::string url);

	// @brief HTTP get request
	// @param url
	// @return 0 if success otherwise -1
	int get(std::string url, const char * buf);

	// @brief HTTP post request
	// @param url, cont specify post content, size specify cont's length 
	// @return 0 if success otherwise -1
	int post(std::string url, const char * cont, size_t size);

	// @brief whether the request header is set
	// @param key
	// @return true if the key is set, otherwise false
	bool requestHeaderIsSet(std::string key);

	// @brief whether the response header is set
	// @param key
	// @return true if the key is set, otherwise false
	bool responseHeaderIsSet(std::string key);
	
	// @brief Set request header
	// @param key, value
	// @return 
	void setRequestHeader(std::string key, std::string value);

	// @brief Return all request headers
	// @param void
	// @ all request headers represented by map
	map<std::string, std::string> getAllRequestHeaders(void);

	// @brief Return value specified by key
	// @param key
	// @return key's value represented by string
	std::string getResponseHeader(std::string key);

	// @brief Return all response header
	// @return all headers represented by map
	map<std::string, std::string> getAllResponseHeaders(void);

	// @brief Return HTTP response code, 200/404/500 etc
	// @return status code represented by integer
	int status(void);

	// @brief HTTP response text, the parameter text will contain the response data
	// @param text
	// @return
	void responseText( Chars &text );

	// @brief Return the HTTP version
	// @return the version of HTTP represented by string
	std::string version(void);

	// @brief Set send timeout
	// @param sec seconds, ms microseconds
	// @return void
	void setSendTimeout(int sec, int usec);

	// @brief Set receive timeout
	// @param sec seconds, ms microseconds
	// @return void
	void setRecvTimeout(int sec, int usec);

	//
	// Set No Blocking
	//
	bool setNonblocking(void);

	//
	// Set Blocking
	//
	bool setBlocking(void);


protected:
	// @brief Connect to an address specified by url
	// @param url, port
	// @return connected socket on success or -1 when an error occurred
	// 
	SOCKET tcpConnect(std::string url, std::string port = "80");

	// @brief Compare two string ignore case
	// @param lhs, rhs
	// @return 0 lhs == rhs, 1 lhs > rhs, -1 lhs < rhs
	int iCompare(std::string lhs, std::string rhs);

	// @brief Parse a URL and return its components
	// @param url
	// @return URL components represented by map
	map<std::string, std::string> parseUrl(std::string url);

	
	// @brief Hexadecimal to decimal
	// @param hexa
	// @return integer represented with Hexadecimal
	int hexToDecimal(const char *hexa);

		
protected:
	std::string m_addr;
	std::string m_uri;
	std::string m_query;	
	std::string m_port;

	std::string m_status;
	std::string m_version;
	std::map<std::string, std::string> m_requestHeader;
	std::map<std::string, std::string> m_responseHeader;
	Chars m_responseText;
	Chars m_requestText;

	SOCKET m_socket;
	sockaddr_in m_sockaddr;
};

#endif	// end __QLIB_HTTP_H
