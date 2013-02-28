#ifndef __HTTPSERVER_H
#define __HTTPSERVER_H

#include "socket.h"
#include "tcpserver.h"
#include "httpclient.h"


class HTTPServer : public HTTPClient
{
public:
	// Construct
	HTTPServer();

	// Destruct
	~HTTPServer();

	// @brief This method returns request method
	// @return m_method
	string method(void);

	// @brief This method returns request uri
	// @return uri 
	string getUri(void);

	// @brief Return all request headers
	// @return Return a copy of request header in map
	map<string, string> getAllRequestHeaders(void);

	// @brief Listen on specified host and service
	// @param hostname The host listened on
	// @param service Service name or port number
	// @param addrlenp Retrieve the len of address which listened on
	// @return If no error occurs returns a connected socket, Otherwise return INVALID_SOCKET
	virtual SOCKET listen(const char *hostname, const char* service, socklen_t *addrlenp);

	// @brief Bind to specify address or server
	// @param host The host which to bind
	// @param serv The service to bind
	// @param pFunc Call back function which invoked when a connection reached
	// @return zero on success, otherwise -1 is returns
	virtual int bind(const char * host, const char * serv, SOCK_CALL_BACK pFunc);

	// @brief Wait for main thread to end
	virtual void wait(void);

	// @brief Stop Main thread
	virtual bool stop(void);

protected:
	// @brief This method process receive data
	// @return If no error occurs, Returns 1, If receive buffer
	// if empty returns zero, Otherwise returns -1.
	virtual int dataProcess(void);

	friend void * HTTPSubThreadProc(void *param);

	friend void HTTPMainThreadProc(void *param);
protected:
	// The call back function pointer
	SOCK_CALL_BACK m_pfunc;

	// Main thread
	tthread::thread *m_pMainThread;

	// Stop flags
	bool m_stop_flags;

	// Is main thread stop
	bool m_is_main_thread_stop;

	// Sub thread pointer
	SubThreadPointer m_sub_pfunc;

};

#endif


