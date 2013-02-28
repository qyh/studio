#ifndef __SOCKET_H
#define __SOCKET_H

#ifdef _WIN32
#include <WinSock2.h>
#include <io.h>
#include <Ws2tcpip.h>
#pragma warning(disable:4996)
#define snprintf _snprintf

#define SHUT_RD		SD_RECEIVE
#define SHUT_WR		SD_SEND
#define SHUT_RDWD	SD_BOTH
#else
#include <errno.h>
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
#include <exception>

#include "chars.h"

// The class Socket does not provide a connect 
// method to establish a connection
class Socket;

typedef void (*SOCK_CALL_BACK)(void *);

class Socket
{
public:
	// Construct
	Socket(int af, int type, int protocol);

	// Destruct
	virtual ~Socket();

	// Copy construct
	Socket(const Socket& rhs);

	// operator =
	Socket & operator=(const Socket& rhs);

	// Socket error enum
	typedef enum 
	{
		SOCKET_INVALID = -1,
		SOCKET_SUCCESS = 0,
		SOCKET_INTER,
		SOCKET_TIMEOUT
	}SocketError;

	// @brief The closesocket function closes an existing socket.
	// @param void
	// @return If no error occurs, closesocket return
	// zero.Otherwise a value of -1 is return
	virtual int closesocket(void);

	// @brief Returns the received data length in bytes
	// @param void
	// @return The receive data's length in bytes
	virtual size_t length(void) const;

	// @brief The recv method receives data
	// from a connected or bound socket.
	// @param The length, in bytes.
	// @return If no error occurs, returns the 
	// number of bytes received. If the connection
	// has been gracefully closed, the return value
	// is zero, otherwise -1 is return
	virtual int recv( int len );

	// @brief Peeks at the incoming data. the data is
	// copied into the buf parameter but is not
	// removed from the input queue.
	// @param buf A buffer to store receive data,
	// len The length in bytes to peek.
	// @return Return the number of bytes currently pending to receive.
	virtual int peek( char *buf, int len );
	
	// @brief Send data on a connected socket
	// @param buf A pointer to a buffer containing the data to be transmitted.
	// len The length, in bytes of the data in buffer pointed to by the buf parameter
	// @return If no error occurs return the total number of bytes sent which can be less
	// than the number requested to be sent in len parameter. Otherwise
	// -1 is returned.
	virtual int send( const char* buf, int len );

	// @brief The shutdown method disable sends or receive s on socket
	// @param mode Flag that describes what types
	// of operation will no longer allowed.
	// @return If no error occurs, returns zero.
	// Otherwise -1 is returns
	virtual int shutdown(int mode);

	// Set the socket to blocking.
	// @return true if successful set to blocking, else return false;
	virtual bool setBlocking(void);

	// Set the socket as non-blocking.
	// @return true if successful set to non-blocking, else return false;
	virtual bool setNonblocking(void);

	// @brief The setsockopt method sets a socket option
	// @param level The level at which the option is defined(SOL_SOCKET)
	// @param optname The socket option for which the value is to be set,
	// The optname parameter must be a socket option defined within the 
	// specified level or behavior is undefined .
	// @param optval A pointer to the buffer in which value for the request option
	// is specified.
	// @param optlen The size , in bytes of the optval buffer.
	// @return If no error occurs, returns zero, Otherwise -1 is returns 
	virtual int setsockopt(int level, int optname, const void *optval, int optlen);

	// @brief The getsockopt method retrieves a socket option
	// @param level The level at which option is defined. Example: SOL_SOCKET
	// @param optname The socket option which the value is to be retrieved.(SO_ACCEPTCONN)
	// @param optval A pointer to the buffer in which the value for the
	// requested option is to be returned
	// @param optlen A pointer to the size, in bytes of the optval buffer.
	virtual int getsockopt(int level, int optname, void *optval, int *optlen);


	// @brief Return receive data with C style
	// @return const char* The C style string
	virtual const char* c_str(void) const;

	// @brief Set receive timeout
	// @param ms Microseconds to set
	// @return If no error occurs zero is returns, Otherwise -1 is returns
	virtual int setRcvTimeout(int ms);

	// @brief Set send timeout
	// @param ms Microseconds to set
	// @return If no error occurs zero is returns, Otherwise -1 is returns
	virtual int setSndTimeout(int ms);

	// @brief Receive data from a valid socket 'fd'
	// @param fd The socket which receive from, It must be a valid socket
	// @param buf The buffer for incoming data
	// @param size Length of the buf parameter
	// @param timeout Specify receive timeout in microseconds
	// @return If success return the number of bytes received, Otherwise -1 is returns
	static int Recv(SOCKET fd, char *buf, int size, int timeout);
	
	// @brief Send data on a connected socket
	// @param fd The socket which send to, It must be a valid socket
	// @param buf Buffer containing the data to be transmitted.
	// @param size Length of the data in the buf parameter.
	// @param timeout Specify sent timeout in microseconds
	// @return If success returns the number of bytes sent, Otherwise -1 is returns.
	static int Send(SOCKET fd, const char * buf, int size, int timeout);

	// @brief This method check whether the socket is blocking or not
	// @return If the socket is block returns true, Otherwise returns false.
	bool isBlocking(void);

	// @return sockaddr
	struct sockaddr* getsockaddr(void);

	// @return remote sockaddr
	struct sockaddr* getremoteaddr(void);

	// @return sockaddr len
	socklen_t getaddrlen(void);

	// @return remote sockaddr len
	socklen_t getremoteaddrlen(void);

	// @return socket type
	int getsocktype(void);

	// @return socket family
	int getsockfamily(void);

	

protected:
	// Real socket of class
	SOCKET	m_socket;

	// sockaddr
	struct sockaddr *m_sockaddr;

	// remote sockaddr
	struct sockaddr *m_remoteaddr;

	// sockaddr length
	socklen_t m_addrlen;

	// remote sockaddr len
	socklen_t m_remoteaddrlen;

	// Receive buffer
	Chars   m_recv_buffer;
	
	// Is blocking or not 
	bool m_isBlocking;

	// Socket family
	int m_family;

	// Socket type
	int m_socktype;

	// Socket protocol
	int m_protocol;

};

#endif 


