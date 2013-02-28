#include "socket.h"

// Construct
Socket::Socket(int af, int type, int protocol)
{
	m_family = af;
	m_socktype = type;
	m_protocol = protocol;
#ifdef _WIN32
	WSADATA wsaData;
	int iResult = WSAStartup(MAKEWORD(2,2), &wsaData);

#endif
	if ( (m_socket = socket(af, type, protocol)) < 0) {
		m_socket = INVALID_SOCKET;
		// translate socket error here
	}
	m_isBlocking = true;

	// Initialize sockaddr
	m_sockaddr = (struct sockaddr*)new char[sizeof(struct sockaddr_storage)];
	m_remoteaddr = (struct sockaddr*)new char[sizeof(struct sockaddr_storage)];
	m_addrlen = 0;
	m_remoteaddrlen = 0;

}

// Destruct
Socket::~Socket()
{
#ifdef _WIN32
	if (m_socket != INVALID_SOCKET) {
		this->closesocket();
	}
	WSACleanup();
#else
	if (m_socket != INVALID_SOCKET) {
		this->closesocket();
	}
#endif

	if (m_sockaddr != NULL) {
		delete m_sockaddr;
		m_addrlen = 0;
	}
	if (m_remoteaddr != NULL) {
		delete m_remoteaddr;
		m_remoteaddrlen = 0;
	}
	m_addrlen = 0;

}

// Copy construct
Socket::Socket(const Socket& rhs)
{
	m_sockaddr = (struct sockaddr*)new char[sizeof(struct sockaddr_storage)];
	m_remoteaddr = (struct sockaddr*)new char[sizeof(struct sockaddr_storage)];
	m_addrlen = m_remoteaddrlen = 0;
	*this = rhs;
}

// operator =
Socket & Socket::operator=(const Socket& rhs)
{
	if (&rhs != this) {
		m_socket = rhs.m_socket;
		m_addrlen = rhs.m_addrlen;
		m_recv_buffer = rhs.m_recv_buffer;
		m_isBlocking = rhs.m_isBlocking;
		m_family = rhs.m_family;
		m_socktype = rhs.m_socktype;
		m_protocol = rhs.m_protocol;
		
		if (rhs.m_sockaddr != NULL && rhs.m_addrlen != 0) {
			// If has data, copy it
			if (m_sockaddr == NULL) {
				m_sockaddr = (struct sockaddr*)new char[rhs.m_addrlen];
			}
			memcpy(m_sockaddr, rhs.m_sockaddr, rhs.m_addrlen);
		}

		if (rhs.m_remoteaddr != NULL && rhs.m_remoteaddrlen != 0) {
			// If has data, copy it
			if (m_remoteaddr == NULL) {
				m_remoteaddr = (struct sockaddr*)new char[rhs.m_remoteaddrlen];
			}
			memcpy(m_remoteaddr, rhs.m_remoteaddr, rhs.m_remoteaddrlen);
		}
	}
	return *this;
}

#if 0
// Operator =
Socket & Socket::operator =(const Socket& rhs) 
{
	if (&rhs == this) {
		return *this;
	}
	this->m_sockaddr = rhs.m_sockaddr;
	this->m_addrlen = rhs.m_addrlen;
	this->m_family = rhs.m_family;
	this->m_isBlocking = rhs.m_isBlocking;
	this->m_protocol = rhs.m_protocol;
	this->m_recv_buffer = rhs.m_recv_buffer;
	this->m_socktype = rhs.m_socktype;
	this->m_socket = m_socket;
	if (rhs.m_sockaddr != NULL) {
		memcpy(this->m_sockaddr, rhs.m_sockaddr, rhs.m_addrlen);
	}

	return *this;

}
#endif 
// @brief The closesocket function closes an existing socket.
// @param void
// @return If no error occurs, closesocket return
// zero.Otherwise a value of SOCKET_ERROR is return
int Socket::closesocket(void)
{
#ifdef _WIN32
	return ::closesocket(m_socket);
#else
	return close(m_socket);
#endif
}

// @brief The recv method receives data
// from a connected or bound socket.
// @param The length, in bytes.
// @return If no error occurs, returns the 
// number of bytes received. If the connection
// has been gracefully closed, the return value
// is zero, otherwise -1 is return
int Socket::recv( int len )
{
	int nRcv = 0;
	char * pBuf = new char[len];
	if (pBuf == NULL || len <= 0) {
		return -1;
	}
	if (m_socket == INVALID_SOCKET) {
		// translate error here
		delete[] pBuf;
		return -1;
	}

	do 
	{
		nRcv = ::recv(m_socket, pBuf, len, 0);

#ifdef _WIN32
	} while (WSAGetLastError() == WSAEINTR);
#else
	} while (errno == EINTR);
#endif 


	if (nRcv > 0) {
		m_recv_buffer.append(pBuf, nRcv);
		
	}

	delete pBuf;

	return nRcv;

}

// @brief Peeks at the incoming data. the data is
// copied into the buf parameter but is not
// removed from the input queue.
// @param buf A buffer to store receive data,
// len The length in bytes to peek.
// @return Return the number of bytes currently pending to receive.
int Socket::peek( char *buf, int len )
{
	int nRcv = 0;
	if (buf == NULL || len <= 0) {
		return -1;
	}

	if (m_socket == INVALID_SOCKET) {
		// translate error here
		return -1;
	}

	for (;;) 
	{
		do 
		{
			nRcv = ::recv(m_socket, buf + nRcv, len, MSG_PEEK);
	
#ifdef _WIN32
		} while (WSAGetLastError() == WSAEINTR);
#else
		} while (errno == EINTR);
#endif

			break;
	}
	return nRcv;
}

// @brief Send data on a connected socket
// @param buf A pointer to a buffer containing the data to be transmitted.
// len The length, in bytes of the data in buffer pointed to by the buf parameter
// @return If no error occurs return the total number of bytes sent which can be less
// than the number requested to be sent in len parameter. Otherwise
// -1 is returned.
int Socket::send( const char* buf, int len )
{
	int nSnd = 0;
	if (buf == NULL || len <= 0) {
		return -1;
	}

	if (m_socket == INVALID_SOCKET) {
		// translate error here
		return -1;
	}

	for (;;) 
	{
		do 
		{
			nSnd = ::send(m_socket, buf + nSnd, len, 0);
			
#ifdef _WIN32
		} while (WSAGetLastError() == WSAEINTR);
#else
		} while (errno == EINTR);
#endif 
			
			break;
	}
	return nSnd;
}

// @brief The shutdown method disable sends or receive s on socket
// @param mode Flag that describes what types
// of operation will no longer allowed.
// @return If no error occurs, returns zero.
// Otherwise -1 is returns
int Socket::shutdown(int mode)
{
	return ::shutdown(m_socket, mode);
	// translate error here
}

// Set the socket to blocking.
// @return true if successful set to blocking, else return false;
bool Socket::setBlocking(void)
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
	m_isBlocking = true;

	return true;
}

// Set the socket as non-blocking.
// @return true if successful set to non-blocking, else return false;
bool Socket::setNonblocking(void)
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

	m_isBlocking = false;

	return true;
}

// @brief The setsockopt method sets a socket option
// @param level The level at which the option is defined(SOL_SOCKET)
// @param optname The socket option for which the value is to be set,
// The optname parameter must be a socket option defined within the 
// specified level or behavior is undefined .
// @param optval A pointer to the buffer in which value for the request option
// is specified.
// @param optlen The size , in bytes of the optval buffer.
// @return If no error occurs, returns zero, Otherwise -1 is returns 
int Socket::setsockopt(int level, int optname, const void *optval, int optlen)
{
#ifdef _WIN32
	return ::setsockopt(m_socket, level, optname, (char *)optval, optlen);
#else
    socklen_t len = optlen;
	return ::setsockopt(m_socket, level, optname, optval, len);
#endif
}

// @brief The getsockopt method retrieves a socket option
// @param level The level at which option is defined. Example: SOL_SOCKET
// @param optname The socket option which the value is to be retrieved.(SO_ACCEPTCONN)
// @param optval A pointer to the buffer in which the value for the
// requested option is to be returned
// @param optlen A pointer to the size, in bytes of the optval buffer.
int Socket::getsockopt(int level, int optname, void *optval, int *optlen)
{
#ifdef _WIN32
	return ::getsockopt(m_socket, level, optname, (char *)optval, optlen);
#else 
	return ::getsockopt(m_socket, level, optname, optval, (socklen_t*)optlen);
#endif 
}

// @brief Return receive data with C style
// @return const char* The C style string
const char* Socket::c_str(void) const
{
	return (m_recv_buffer.c_str());
}

// @brief Set receive timeout
// @param ms Microseconds to set
// @return If no error occurs zero is returns, Otherwise -1 is returns
int Socket::setRcvTimeout(int ms)
{
#ifdef _WIN32
	int ns = ms;
	return this->setsockopt(SOL_SOCKET, SO_RCVTIMEO, (char*)&ns, sizeof(ns));
#else
	timeval tv;
	tv.tv_sec = ms/1000;
	tv.tv_usec = ms * 1000 - (tv.tv_sec * 1000 * 1000);
	return this->setsockopt(SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
#endif
}

// @brief Set send timeout
// @param ms Microseconds to set
// @return If no error occurs zero is returns, Otherwise -1 is returns
int Socket::setSndTimeout(int ms)
{
#ifdef _WIN32
	int ns = ms;
	return this->setsockopt(SOL_SOCKET, SO_SNDTIMEO, (char*)&ns, sizeof(ns));
#else
	timeval tv;
	tv.tv_sec = ms/1000;
	tv.tv_usec = ms * 1000 - (tv.tv_sec * 1000 * 1000);
	return this->setsockopt(SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));
#endif
}

// @brief Receive data from a valid socket 'fd'
// @param fd The socket which receive from, It must be a valid socket
// @param buf The buffer for incoming data
// @param size Length of the buf parameter
// @param timeout Specify receive timeout in microseconds
// @return If success return the number of bytes received, Otherwise -1 is returns
int Socket::Recv(SOCKET fd, char *buf, int size, int timeout)
{
	timeval tv;
	int nRcv = 0;
	if (timeout > 0) {
		tv.tv_sec = 0;
		tv.tv_usec = timeout * 1000;
	}
	if (fd == INVALID_SOCKET) {
		return -1;
	}
	// Set receive timeout
#ifdef _WIN32
	::setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv));
#else
	::setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
#endif

	// Set blocking
#ifdef _WIN32
#else 
#endif
	for ( ; ; )
	{
		do 
		{	
			nRcv = ::recv(fd, buf+nRcv, size, 0);
	
#ifdef _WIN32
		} while ( WSAGetLastError() == WSAEINTR );
#else
		} while ( errno == EINTR);
#endif

		break;

	}// end for(;;)



	return nRcv;
}

// @brief Send data on a connected socket
// @param fd The socket which send to, It must be a valid socket
// @param buf Buffer containing the data to be transmitted.
// @param size Length of the data in the buf parameter.
// @param timeout Specify sent timeout in microseconds
// @return If success returns the number of bytes sent, Otherwise -1 is returns.
int Socket::Send(SOCKET fd, const char * buf, int size, int timeout)
{
	timeval tv;
	int nSnd = 0;
	if (timeout > 0) {
		tv.tv_sec = 0;
		tv.tv_usec = timeout * 1000;
	}
	if (fd == INVALID_SOCKET) {
		return -1;
	}
	// Set receive timeout
#ifdef _WIN32
	::setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv));
#else
	::setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
#endif

	// Set blocking
#ifdef _WIN32
#else 
#endif
	for ( ; ; )
	{
		do 
		{	
			nSnd = ::send(fd, buf+nSnd, size, 0);

#ifdef _WIN32
		} while ( WSAGetLastError() == WSAEINTR );
#else
		} while ( errno == EINTR);
#endif

		break;

	}// end for(;;)

	return nSnd;
}

// @brief Returns the received data length in bytes
// @param void
// @return The receive data's length in bytes
size_t Socket::length(void) const
{
	return m_recv_buffer.length();
}

// @brief This method check whether the socket is blocking or not
// @return If the socket is block returns true, Otherwise returns false.
bool Socket::isBlocking(void)
{
	return m_isBlocking;
}

// @return sockaddr
struct sockaddr* Socket::getsockaddr(void)
{
	return m_sockaddr;
}

// @return remote sockaddr
struct sockaddr* Socket::getremoteaddr(void)
{
	return m_remoteaddr;
}

// @return sockaddr len
socklen_t Socket::getaddrlen(void)
{
	return m_addrlen;
}

// @return remote sockaddr len
socklen_t Socket::getremoteaddrlen(void)
{
	return m_remoteaddrlen;
}

// @return socket type
int Socket::getsocktype(void)
{
	return m_socktype;
}

// @return socket family
int Socket::getsockfamily(void)
{
	return m_family;
}



