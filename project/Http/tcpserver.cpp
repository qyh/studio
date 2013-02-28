#include "tcpserver.h"
#include "fast_mutex.h"
#include "tinythread.h"
#include "chars.h"
#include "logger.h"

#ifdef _WIN32
#include <process.h>
#include <pthread.h>
#endif 


using namespace tthread;

static fast_mutex ListenfdLock;
void * SubThreadProc(void *param);
void MainThreadProc(void *param);

// Construct
TCPServer::TCPServer():Socket(AF_INET, SOCK_STREAM, 0)
{
	m_stop_flags = false;
	m_is_main_thread_stop = false;
	m_pMainThread = NULL;
	m_sub_pfunc = SubThreadProc;
}

// Destruct
TCPServer::~TCPServer()
{
	if (m_pMainThread != NULL)
		delete m_pMainThread;
}

// @brief Listen on specified host and service
// @param hostname The host listened on
// @param service Service name or port number
// @param addrlenp Retrieve the len of address which listened on
// @return If no error occurs returns a connected socket, Otherwise return INVALID_SOCKET
SOCKET TCPServer::listen(const char *hostname, const char* service, socklen_t *addrlenp)
{
	SOCKET listenfd;
	int n;
	const int on = 1;
	struct addrinfo hints, *res, *ressave;

	memset(&hints, 0, sizeof(struct addrinfo));
	hints.ai_flags = AI_PASSIVE;
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;

	if ( (n = getaddrinfo(hostname, service, &hints, &res)) != 0 ) {
		return -1;
	}
	ressave = res;

	do 
	{
		listenfd = ::socket(res->ai_family, res->ai_socktype, res->ai_protocol);
		if (listenfd < 0) {
			// error try next
			continue;
		}
		::setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, (const char*)&on, sizeof(on));
		if (::bind(listenfd, res->ai_addr, res->ai_addrlen) == 0) {
			// Success
			break;
		}

		this->closesocket();

	} while ( (res = res->ai_next) != NULL );

	// Error from final socket() or bind()
	if (res == NULL) {
		return INVALID_SOCKET;
	}
	const int LISTENQ = 1024;
	::listen(listenfd, LISTENQ);
	if (addrlenp) {
		// Return size of protocol address
		*addrlenp = res->ai_addrlen;
	}
	m_addrlen = res->ai_addrlen;
	memcpy(m_sockaddr, res->ai_addr, res->ai_addrlen);

	freeaddrinfo(ressave);

	m_socket = listenfd;

	return (listenfd);
}

// @brief This method process receive data
// @return If no error occurs, Returns 0, Otherwise returns -1.
int TCPServer::dataProcess(void)
{
	char *s = new char[m_recv_buffer.length() + 1];
	if (s == NULL) 
		return -1;
	memcpy(s, m_recv_buffer.c_str(), m_recv_buffer.length());
	s[m_recv_buffer.length()] = 0;
	printf("%s", s);
	delete s;
	return 0;
}

// Sub thread
void * SubThreadProc(void *param)
{
	ListenfdLock.lock();
	TCPServer cli = *((TCPServer*)param);
    TCPServer *p = (TCPServer*)param;
	p->m_socket = INVALID_SOCKET;
	delete p;
	p = NULL;
	ListenfdLock.unlock();
	Chars chars;
	SOCKET listenfd = cli.m_socket;

	SOCKET connfd = ::accept(listenfd, cli.m_remoteaddr, &cli.m_remoteaddrlen);
	if (connfd == INVALID_SOCKET) {
		Logger::Write("TCP SubThreadProc", Logger::LOG_INFO, "Invalid socket");
		return NULL;
	}
	

	cli.m_socket = connfd;
	
	cli.setRcvTimeout(1000);
	cli.setSndTimeout(1000);
	int n = 0;
	while ( true ){
		n = cli.recv(1024);
		if ( (n > 0 && n < 1024) || (n <= 0) ) {
			break;
		} else if (n == 1024) {
			continue;
		}
	}
		

	/*int nRel = cli.dataProcess();*/

	cli.m_pfunc(&cli);
	return NULL;
}

// Main thread
void MainThreadProc(void *param)
{
	TCPServer * tcpserv = (TCPServer *)param;
	fd_set rset, wset, eset;

	timeval tv;
	tv.tv_sec = 5;
	tv.tv_usec = 0;

	
	// Select loop
	for ( ; !tcpserv->m_stop_flags ; ) 
	{
		// Initialize fd_set
		FD_ZERO(&rset);
		FD_SET(tcpserv->m_socket, &rset);
		wset = eset = rset;

		if (select(tcpserv->m_socket + 1, &rset, &wset, &eset, &tv) <= 0){
			continue;
		}
		if (!FD_ISSET(tcpserv->m_socket, &rset)) {
			continue;
		}

		ListenfdLock.lock();
		TCPServer *p = new TCPServer;
		p->m_socket = tcpserv->m_socket;
		p->m_pfunc = tcpserv->m_pfunc;
		p->m_sub_pfunc = tcpserv->m_sub_pfunc;
		ListenfdLock.unlock();

		pthread_t tid;
		pthread_create(&tid, NULL, p->m_sub_pfunc, (void*)p);
		pthread_detach(tid);

#if 0
#ifdef _WIN32
		_beginthread(SubThreadProc, 0, (void *)p);
#else
		pthread_t tid;
		pthread_create(&tid, NULL, SubThreadProc, (void*)p);
		pthread_detach(tid);
#endif
#endif
		
	}
	tcpserv->m_is_main_thread_stop = true;

}

// @brief Bind to specify address or server
// @param host The host which to bind
// @param serv The service to bind
// @param pFunc Call back function which invoked when a connection reached
// @return zero on success, otherwise -1 is returns
int TCPServer::bind(const char * host, const char * serv, SOCK_CALL_BACK pFunc)
{
	if (listen(host, serv, NULL) == INVALID_SOCKET) {
		return -1;
	}
	m_pfunc = pFunc;

	m_pMainThread = new tthread::thread(MainThreadProc, (void *)this);
	
	//m_pMainThread->join();

	return 0;
}

// @brief Wait for main thread to end
void TCPServer::wait(void)
{

	if (m_pMainThread->joinable())
		m_pMainThread->join();
}

// @brief Stop Main thread
bool TCPServer::stop(void)
{
	m_stop_flags = true;
	while (!m_is_main_thread_stop)
	{
		Utility::sleepms(100);
	}
	return true;
}
