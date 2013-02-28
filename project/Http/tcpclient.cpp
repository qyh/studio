#include "tcpclient.h"

// Construct
TCPClient::TCPClient(): Socket(m_family, m_socktype, m_protocol)
{
	//__super::Socket(m_family, m_socktype, m_protocol);
}

// Destruct
TCPClient::~TCPClient()
{

}

// @brief Connect to remote host
// @param host The host name of server,
// @param serv Server's name or port number
// @return If no error occurs returns 0, Otherwise -1 is returns.
int TCPClient::connect(const char *host, const char* serv)
{
	SOCKET sockfd;
	int n;

	struct addrinfo hints, *res, *ressave;
	memset(&hints, 0, sizeof(struct addrinfo));
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if ( (n = getaddrinfo(host, serv, &hints, &res)) != 0 ) {
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

		// Close socket
		this->closesocket();

	} while ((res = res->ai_next) != NULL);
	m_addrlen = res->ai_addrlen;
	memcpy(m_sockaddr, res->ai_addr, res->ai_addrlen);
	m_host = host;
	m_port = serv;
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
	m_socket = sockfd;

	return 0;
}

