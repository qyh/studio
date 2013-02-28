#ifdef _WIN32
#include <conio.h>	// for toupper() function
#include <ctype.h>
#include <string.h>
#else
#include <errno.h>
#include <sys/errno.h>
#endif

#include <cmath>
#include <iostream>
#include <exception>
#include "http.h"

using namespace std;

// Constructor
HTTP::HTTP()
{
#ifdef _WIN32
	m_socket = INVALID_SOCKET;
#else
	m_socket = -1;
#endif
}

HTTP::~HTTP()
{
#ifdef _WIN32
	if (m_socket != INVALID_SOCKET) {
		closesocket(m_socket);
	}
	WSACleanup();
#else
	if ( m_socket != -1 ) {
		close(m_socket);
	}
#endif
}

// @brief Compare two string ignore case
// @param lhs, rhs
// @return 0 lhs == rhs, 1 lhs > rhs, -1 lhs < rhs
int HTTP::iCompare(std::string lhs, std::string rhs)
{
#ifdef _WIN32
	return _strnicmp(lhs.c_str(), rhs.c_str(), lhs.length());
#else
	return strnicmp(lhs.c_str(), rhs.c_str(), lhs.length());
#endif
	
}

// @brief Set send timeout
// @param sec seconds, usec microseconds
void HTTP::setSendTimeout(int sec, int usec)
{
	struct timeval tv;
	tv.tv_sec = sec;
	tv.tv_usec = usec;
	//setsockopt(m_socket, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
}

// @brief Set receive timeout
// @param sec seconds, ms microseconds
void HTTP::setRecvTimeout(int sec, int usec)
{
	struct timeval tv;
	tv.tv_sec = sec;
	tv.tv_usec = usec;
	//setsockopt(m_socket, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
}

// @brief Parse a URL and return its components
// @param url
// @return URL components represented by map, an empty map will be return 
// when the url invalid
map< std::string, std::string > HTTP::parseUrl(std::string url)
{
	map< std::string, std::string > splitUrlMap;
	// http://127.0.0.1:80/index.php?user=name&passwd=ps
	int n = 0, k = 0;
	std::string addr = "", portStr = "80", uri = "/", query = "";
	// Go through the url
	// Reset url to point PAST the http://
	if ((n = url.find("://")) != string::npos) {
		url = url.substr(n + 3, url.length() - n - 3);
	}
	
	// 127.0.0.1:80/uri?query
	// Get addr and port
	if ((n = url.find_first_of(':')) == string::npos) {
		// Not found ':' and '/'
		if ((k = url.find_first_of('/')) == string::npos) {
			// Doesn't contain uri (127.0.0.1)
			addr = url.substr(0, url.length());
		} else {
			// Has uri (127.0.0.1/uri)
			addr = url.substr(0, k);
		}
	} else {
		// Contain ':' and variable n point to ':' (127.0.0.1:80)
		addr = url.substr(0, n);
		if ((k = url.find_first_of('/')) == string::npos) {
			// Doesn't contain uri (127.0.0.1:80)
			portStr = url.substr(n + 1, url.length() - n - 1);
		} else {
			// Has uri (127.0.0.1:80/uri)
			portStr = url.substr(n + 1, k - n - 1);
		}
	}
	splitUrlMap["url"] = addr;
	splitUrlMap["port"] = portStr;

	// Get URI
	// 127.0.0.1:80/uri?query
	n = url.find_first_of('/');
	if ( n != string::npos && n != url.length() - 1) {
		if ((k = url.find_first_of('?')) == string::npos) {
			// Doesn't contain query string
			uri += url.substr(n + 1, url.length() - 1);
		} else {
			// Has query string
			uri += url.substr(n + 1, k - n - 1);
		}
	}
	splitUrlMap["uri"] = uri;
	// Now url = uri/query OR uri OR / OR uri/
	// Get query string: user=name&passwd=ps
	n = url.find_first_of('?');
	if (n != string::npos) {
		query = url.substr(n + 1, url.length());
	}
	splitUrlMap["query"] = query;
	return splitUrlMap;
}

// @brief Connect to an address specified by url
// @param url, port
// @return connected socket on success or -1 when an error occurred
// 
SOCKET HTTP::tcpConnect(std::string url, std::string port /* = 80 */)
{
	SOCKET sockfd;
	int n;

#ifdef _WIN32
	WSADATA wsaData;
	int iResult = WSAStartup(MAKEWORD(2,2), &wsaData);
	if (iResult != NO_ERROR)
		return -1;
#endif
	struct addrinfo hints, *res, *ressave;
	memset(&hints, 0, sizeof(struct addrinfo));
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if (n = getaddrinfo(url.c_str(), port.c_str(), &hints, &res) != 0) {
		return -1;
	}
	ressave = res;
	do {
		sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
		if (sockfd < 0) {
			continue;
		}
		if (::connect(sockfd, res->ai_addr, res->ai_addrlen) == 0) 
			break;
#ifdef _WIN32
		closesocket(sockfd);
#else
		close(sockfd);
#endif
	} while ((res = res->ai_next) != NULL);

	freeaddrinfo(ressave);

#if 0
	struct sockaddr_in remoteAddr;
	int iret;
	if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) == INVALID_SOCKET ) {
		return sockfd;
	}

	memset(&remoteAddr, 0, sizeof(remoteAddr));
	remoteAddr.sin_family = AF_INET;
	remoteAddr.sin_port = htons(port);
	//#ifndef _WIN32
	if ((iret = inet_pton(AF_INET, addr, &remoteAddr.sin_addr)) <= 0) {
		return iret;
	}
	//#else
	//		remoteAddr.sin_addr.s_addr = inet_addr( addr );

	//#endif

	if ((iret = connect(sockfd, (struct sockaddr *)&remoteAddr, sizeof(remoteAddr))) < 0) {
		return iret;
	}
#endif
	return sockfd;
}

// @brief Set request header
// @param key, value
// @return 
void HTTP::setRequestHeader(std::string key, std::string value)
{
	m_requestHeader[key] = value;
}

// @brief Return value specified by key
// @param key
// @return key's value represented by string
std::string HTTP::getResponseHeader(std::string key)
{
	map< std::string, std::string >::iterator iter;
	if ( (iter = m_responseHeader.find(key)) != m_responseHeader.end()) {
		return iter->second;
	} else {
		return std::string("");
	}
}

// @brief Return all response header
// @return all headers represented by map
map< std::string, std::string > HTTP::getAllResponseHeaders(void)
{
	return m_responseHeader;
}

// @brief Return all request headers
// @param void
// @ all request headers represented by map
map< std::string, std::string > HTTP::getAllRequestHeaders(void)
{
	return m_requestHeader;
}

// @brief Return HTTP response code, 200/404/500 etc
// @return status code represented by integer
int HTTP::status(void)
{
	return atoi(m_status.c_str());
}


// @brief Return the HTTP version
// @return the version of HTTP represented by string
std::string HTTP::version(void)
{
	return m_version;
}

// @brief whether the request header is set
// @param key
// @return true if the key is set, otherwise false
bool HTTP::requestHeaderIsSet(std::string key)
{
	map< std::string, std::string >::iterator iter;
	if ((iter = m_requestHeader.find(key)) != m_requestHeader.end()) {
		return true;
	} else {
		return false;
	}
}

// @brief whether the response header is set
// @param key
// @return true if the key is set, otherwise false
bool HTTP::responseHeaderIsSet(std::string key)
{
	map< std::string, std::string >::iterator iter;
	if ((iter = m_responseHeader.find(key)) != m_responseHeader.end()) {
		return true;
	} else {
		return false;
	}
}

// @brief Open a connect 
// @param string url an address to be open
// @return 0 if success otherwise -1
int HTTP::open(const std::string url)
{
	if (url.empty()) {
		return -1;
	}
	if (m_socket == INVALID_SOCKET) {
		// Parse url
		map< string, string > urlMap = parseUrl(url);

		// Get remote address
		m_addr = urlMap["url"];

		// Get port
		m_port = urlMap["port"];

		// Get URI
		m_uri = urlMap["uri"];

		// Connect to remote address
		m_socket = tcpConnect(m_addr, m_port);

		if (m_socket == INVALID_SOCKET) {
			return -1;
		}
	}
	return 0;
}

// @brief HTTP get request
// @param url
// @return 0 if success otherwise -1
int HTTP::get(std::string url, const char * query)
{
	if (!url.empty() && m_socket == INVALID_SOCKET) {
		// Parse url
		map< string, string > urlMap = parseUrl(url);

		// Get remote address
		m_addr = urlMap["url"];

		// Get port
		m_port = urlMap["port"];

		// Get URI
		m_uri = urlMap["uri"];

		// Connect to remote address
		m_socket = tcpConnect(m_addr, m_port);
	}

#ifdef _WIN32
	if (m_socket == INVALID_SOCKET) {
		return -1;
	}
#else
	if (m_socket == -INVALID_SOCKET) {
		return -1;
	}
#endif

	if (query == NULL) {
		if (!m_query.empty()) {
			m_uri += "?";
			m_uri += m_query;
		}
	} else {
		m_uri += "?";
		m_uri += query;
	}

	// Setting HTTP request header
	std::string sendStr = "";
	sendStr += "GET ";
	sendStr += m_uri;
	sendStr += " HTTP/1.1\r\n";
	sendStr += "Host: ";
	sendStr += m_addr + "\r\n";

	map< std::string, std::string >::iterator it;
	if ((it = m_requestHeader.find("User-Agent")) == m_requestHeader.end()) {
		sendStr += "User-Agent: c++\r\n";
	}
	if ((it = m_requestHeader.find("Connection")) == m_requestHeader.end()) {
		sendStr += "Connection: Keep-Alive\r\n";
	}
	
	// Get headers defined by user
	map< std::string, std::string >::iterator iter = m_requestHeader.begin();
	while (iter != m_requestHeader.end()) {
		sendStr += iter->first + ": ";
		sendStr += iter->second + "\r\n";
	}

	// HTTP request header end
	sendStr += "\r\n";

	// Set receive send time out to 5 seconds
	int nTimeout = 5 * 1000;
	setsockopt(m_socket, SOL_SOCKET, SO_SNDTIMEO,
		(char *)&nTimeout, sizeof(int));
	setsockopt(m_socket, SOL_SOCKET, SO_RCVTIMEO,
		(char *)&nTimeout, sizeof(int));

	// Send request on m_socket
	do 
	{
		long snd = send(m_socket, sendStr.c_str(), sendStr.length(), 0);
		if (snd < (long)sendStr.length()) {
			return -1;
		}
#ifdef _WIN32
	} while (WSAGetLastError() == WSAEINTR);
#else
	} while (errno == EINTR);
#endif
	
	const int MAXSIZE = 4096;
	char recvBuff[MAXSIZE];
	recvBuff[0] = 0;

	int n = 0;

	std::string line = "";
	int lineCount = 0;
	size_t content_length = 0;
	
	do 
	{
		//
		// Receive response data 
		//
		n = recv(m_socket, recvBuff, 1, 0);
		if (n < 1) {
			return -1;
		}
		// 0x0d:\r, 0x0a:\n
		recvBuff[n] = 0;
		line += recvBuff;

		if (line[line.length() - 1] == 0x0a) {
			lineCount++;
			// Erase \r\n
			line = line.substr(0, line.length() - 2);
			// Empty line, header end
			if (line.empty()) {
				break;
			}
			if (lineCount == 1) {
				// The first line: HTTP/1.1 200 OK
				// 0x20: ' '
				m_version = line.substr(0, line.find_first_of(0x20));
				m_status = line.substr(line.find_first_of(0x20) + 1,
					line.find_last_of(0x20) - line.find_first_of(0x20) - 1);
			} else {
				// Process headers: Date: 12
				std::string key = line.substr(0, line.find_first_of(':'));
				std::string value = line.substr(line.find_first_of(':') + 2, 
					line.length() - line.find_first_of(':') - 2);
				m_responseHeader[key] = value;
				// Get Content-Length's value
				if (iCompare(key, "Content-Length") == 0) {
					content_length = atol(value.c_str());
				}
			}

			// Empty line
			line = "";
		} 
		
	} while (true);
	
	// If Content-Length is set
	if (content_length > 0) {
		do 
		{
			char *text = new char[content_length + 1];
			recv(m_socket, text, content_length, 0);
			text[content_length] = 0;
			//m_responseText = text;
			m_responseText.assign(text, content_length);
			delete text;
#ifdef _WIN32

		} while (WSAGetLastError() == WSAEINTR);
#else
		} while (errno == EINTR);
#endif
	} else {
		//
		// Content-Length not set
		//
		int n = 0;
		line = "";

		
		//setNonblocking();
		// Erase \r\n
#if 1
		while ((n = recv(m_socket, recvBuff, 1, MSG_PEEK)) > 0) {
			recvBuff[n] = 0;
			if (recvBuff[0] == 0x0d || recvBuff[0] == 0x0a) {
				// Move pointer to next byte
				recv(m_socket, recvBuff, 1, 0);
				continue;
			}
			break;
		}
		// Read content-length
		for( ;; ) {
			n = recv(m_socket, recvBuff, 1, 0);
			recvBuff[n] = 0;
			line += recvBuff;
			if (line[line.length() - 1] == 0x0a){ // \n
				content_length = hexToDecimal((line.substr(0, line.length() - 2)).c_str());
				break;
			}
		}
#endif
		//setBlocking();
		//content_length = 4096;
		// Read content
		char *text = new char[content_length + 1];
		for ( ;; ) {
			
			long nr = 0;
			do 
			{			
				nr = recv(m_socket, text, content_length, 0);
				
				//m_responseText += text;
				if (nr <= 0) {
					break;
				}
				
				m_responseText.append(text, nr);
				
#ifdef _WIN32

			} while (WSAGetLastError() == WSAEINTR);
#else
			} while (errno == EINTR);
#endif

			if (nr <= 0) {
				break;
			}
		}
		delete[] text;	
		m_responseText = m_responseText.substr(0, m_responseText.length() - 5);
		
	} // end of else
	
	
	return 0;
}

// @brief HTTP post request
// @param url, cont specify post content, size specify cont's length 
// @return 0 if success otherwise -1
int HTTP::post(std::string url, const char * cont, size_t size)
{
	if (!url.empty() && m_socket == INVALID_SOCKET) {
		// Parse url
		map< string, string > urlMap = parseUrl(url);

		// Get remote address
		m_addr = urlMap["url"];

		// Get port
		m_port = urlMap["port"];

		// Get URI
		m_uri = urlMap["uri"];

		// Connect to remote address
		m_socket = tcpConnect(m_addr, m_port);
	}

#ifdef _WIN32
	if (m_socket == INVALID_SOCKET) {
		return -1;
	}
#else
	if (m_socket == -1) {
		return -1;
	}
#endif

	// Setting HTTP request header
	std::string sendStr = "";
	Chars sendText;
	sendStr += "POST ";
	sendStr += m_uri;
	sendStr += " HTTP/1.1\r\n";
	sendStr += "Host: ";
	sendStr += m_addr + "\r\n";
	if (cont != NULL && size > 0) {
		char buf[10];
		sendStr += "Content-Length: ";
		snprintf(buf, 10, "%ld", size);
		sendStr += buf;
		sendStr += "\r\n";
	}

	map< std::string, std::string >::iterator it;
	if ((it = m_requestHeader.find("User-Agent")) == m_requestHeader.end()) {
		sendStr += "User-Agent: c++\r\n";
	}
	if ((it = m_requestHeader.find("Connection")) == m_requestHeader.end()) {
		sendStr += "Connection: Keep-Alive\r\n";
	}

	// Get headers defined by user
	map< std::string, std::string >::iterator iter = m_requestHeader.begin();
	while (iter != m_requestHeader.end()) {
		sendStr += iter->first + ": ";
		sendStr += iter->second + "\r\n";
	}

	// HTTP request header end
	sendStr += "\r\n\r\n";
	if (!sendText.append(sendStr.c_str(), sendStr.length()))
		return -1;
	if (cont != NULL && size > 0) {
		if (!sendText.append(cont, size))
			return -1;
	}

	// Set receive send time out to 5 seconds
	int nTimeout = 5 * 1000;
	setsockopt(m_socket, SOL_SOCKET, SO_SNDTIMEO,
		(char *)&nTimeout, sizeof(int));
	setsockopt(m_socket, SOL_SOCKET, SO_RCVTIMEO,
		(char *)&nTimeout, sizeof(int));
	
	// Send request on m_socket
	do 
	{
		int snd = send(m_socket, sendText.c_str(), sendText.length(), 0);
#ifdef _WIN32
	} while (WSAGetLastError() == WSAEINTR);
#else
	} while (errno == EINTR);
#endif

	const int MAXSIZE = 4096;
	char recvBuff[MAXSIZE];
	recvBuff[0] = 0;

	int n = 0;

	std::string line = "";
	int lineCount = 0;
	size_t content_length = 0;


	do 
	{
		//
		// Receive response data 
		//
		n = recv(m_socket, recvBuff, 1, 0);
		// 0x0d:\r, 0x0a:\n
		recvBuff[n] = 0;
		line += recvBuff;

		if (line[line.length() - 1] == 0x0a) {
			lineCount++;
			// Erase \r\n
			line = line.substr(0, line.length() - 2);
			// Empty line, header end
			if (line.empty()) {
				break;
			}
			if (lineCount == 1) {
				// The first line: HTTP/1.1 200 OK
				// 0x20: ' '
				m_version = line.substr(0, line.find_first_of(0x20));
				m_status = line.substr(line.find_first_of(0x20) + 1,
					line.find_last_of(0x20) - line.find_first_of(0x20) - 1);
			} else {
				// Process headers: Date: 12
				std::string key = line.substr(0, line.find_first_of(':'));
				std::string value = line.substr(line.find_first_of(':') + 2, 
					line.length() - line.find_first_of(':') - 2);
				m_responseHeader[key] = value;
				// Get Content-Length's value
				if (iCompare(key, "Content-Length") == 0) {
					content_length = atol(value.c_str());
				}
			}

			// Empty line
			line = "";
		} 

	} while (true);

	// If Content-Length is set
	if (content_length > 0) {
		do 
		{
			char *text = new char[content_length + 1];
			recv(m_socket, text, content_length, 0);
			text[content_length] = 0;
			//m_responseText = text;
			m_responseText.assign(text, content_length);
			delete text;
#ifdef _WIN32

		} while (WSAGetLastError() == WSAEINTR);
#else
		} while (errno == EINTR);
#endif
	} else {
		//
		// Content-Length not set
		//
		long n = 0;
		line = "";

		
		//setNonblocking();
		// Erase \r\n
#if 1
		while ((n = recv(m_socket, recvBuff, 1, MSG_PEEK)) > 0) {
			recvBuff[n] = 0;
			if (recvBuff[0] == 0x0d || recvBuff[0] == 0x0a) {
				// Move pointer to next byte
				recv(m_socket, recvBuff, 1, 0);
				continue;
			}
			break;
		}
		// Read content-length
		for( ;; ) {
			n = recv(m_socket, recvBuff, 1, 0);
			recvBuff[n] = 0;
			line += recvBuff;
			if (line[line.length() - 1] == 0x0a){ // \n
				content_length = hexToDecimal((line.substr(0, line.length() - 2)).c_str());
				break;
			}
		}
#endif
		//setBlocking();
		//content_length = 4096;
		// Read content
		char *text = new char[content_length + 1];
		for ( ;; ) {

			long nr = 0;
			do 
			{			
				nr = recv(m_socket, text, content_length, 0);

				//m_responseText += text;
				if (nr <= 0) {
					break;
				}

				m_responseText.append(text, nr);

#ifdef _WIN32

			} while (WSAGetLastError() == WSAEINTR);
#else
			} while (errno == EINTR);
#endif

			if (nr <= 0) {
				break;
			}
		}
		delete[] text;	
		m_responseText = m_responseText.substr(0, m_responseText.length() - 5);

	} // end of else


	return 0;
}

// @brief Hexadecimal to decimal
// @param hexa
// @return integer represented with Hexadecimal
int HTTP::hexToDecimal(const char *hexa)
{
	float dec = 0;

	if (strlen(hexa) > 2) {
		if (hexa[0] == '0' && hexa[1] == 'x') {
			hexa += 2;
		}
	}
	int j = strlen(hexa);
	
	for (int i = 0; i < j; i++) {
		if (hexa[i] >= 'A' && hexa[i] <= 'F') {
			dec += (hexa[i] - 'A' + 10) * pow((float)16, j - i - 1);
		}

		if (hexa[i] >= 'a' && hexa[i] <= 'f') {
			dec += (hexa[i] - 'a' + 10) * pow((float)16, j - i - 1);
		}

		if (hexa[i] >= '0' && hexa[i] <= '9') {
			dec += (hexa[i] - '0') * pow((float)16, j - i - 1);
		}

	}
	return (int)dec;
}

//
// Set No blocking
// 
bool HTTP::setNonblocking(void)
{
	int  nCurFlags;

#if WIN32
	nCurFlags = 1;

	if (ioctlsocket(m_socket, FIONBIO, (ULONG *)&nCurFlags) != 0)
	{
		
		return false;
	}
#else
	if ((nCurFlags = fcntl(m_socket, F_GETFL)) < 0)
	{
		
		return false;
	}

	nCurFlags |= O_NONBLOCK;

	if (fcntl(m_socket, F_SETFL, nCurFlags) != 0)
	{
		
		return false;
	}
#endif

	//m_bIsBlocking = false;

	return true;
}

//
// Set Blocking
//
bool HTTP::setBlocking(void)
{
	int nCurFlags;

#if WIN32
	nCurFlags = 0;

	if (ioctlsocket(m_socket, FIONBIO, (ULONG *)&nCurFlags) != 0)
	{
		return false;
	}
#else
	if ((nCurFlags = fcntl(m_socket, F_GETFL)) < 0)
	{
		
		return false;
	}

	nCurFlags &= (~O_NONBLOCK);

	if (fcntl(m_socket, F_SETFL, nCurFlags) != 0)
	{
		
		return false;
	}
#endif
	//m_bIsBlocking = true;

	return true;
}

// @brief HTTP response text, the parameter text will contain the response data
// @param text
// @return
void HTTP::responseText( Chars &text )
{
	text = m_responseText;
}

