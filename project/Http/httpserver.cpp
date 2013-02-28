#include "httpserver.h"
#include "logger.h"


static fast_mutex ObjectLock;
void * HTTPSubThreadProc(void *param);
void HTTPMainThreadProc(void *param);

// Construct
HTTPServer::HTTPServer()
{
	m_stop_flags = false;
	m_is_main_thread_stop = false;
	m_pMainThread = NULL;
	m_sub_pfunc = HTTPSubThreadProc;
}

// Destruct
HTTPServer::~HTTPServer()
{
	if (m_pMainThread != NULL) {
		delete m_pMainThread;
	}
}

// Sub Thread function
void * HTTPSubThreadProc(void *param)
{
	ObjectLock.lock();
	HTTPServer cli = *((HTTPServer*)param);
    HTTPServer *p = (HTTPServer*)param;
	p->m_socket = INVALID_SOCKET;
	delete p;
	p = NULL;
	ObjectLock.unlock();
	Chars chars;
	SOCKET listenfd = cli.m_socket;
	
	SOCKET connfd = ::accept(listenfd, NULL, NULL);
	if (connfd == INVALID_SOCKET) {
		//printf("Invalid connfd\n");
		Logger::Write("HTTPSubThreadProc", Logger::LOG_INFO, "Invalid socket");
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


	int nRel = cli.dataProcess();
    if (nRel != 1) {
        // dataProcess error
        Logger::Write("SubThreadProc", Logger::LOG_INFO, 
			"dataProcess error: %d", nRel);
        return NULL;
    }

	cli.m_pfunc(&cli);
	return NULL;
}

// Main thread
void HTTPMainThreadProc(void *param)
{
	HTTPServer * tcpserv = (HTTPServer *)param;
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

		ObjectLock.lock();
		HTTPServer *p = new HTTPServer;
		p->m_socket = tcpserv->m_socket;
		p->m_pfunc = tcpserv->m_pfunc;
		p->m_sub_pfunc = tcpserv->m_sub_pfunc;
		ObjectLock.unlock();

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
int HTTPServer::bind(const char * host, const char * serv, SOCK_CALL_BACK pFunc)
{
	if (listen(host, serv, NULL) == INVALID_SOCKET) {
		return -1;
	}
	m_pfunc = pFunc;

	m_pMainThread = new tthread::thread(HTTPMainThreadProc, (void *)this);

	//m_pMainThread->join();

	return 0;
}

// @brief Wait for main thread to end
void HTTPServer::wait(void)
{

	if (m_pMainThread->joinable())
		m_pMainThread->join();
}

// @brief Stop Main thread
bool HTTPServer::stop(void)
{
	m_stop_flags = true;
	while (!m_is_main_thread_stop)
	{
		Utility::sleepms(100);
	}
	return true;
}

// @brief Listen on specified host and service
// @param hostname The host listened on
// @param service Service name or port number
// @param addrlenp Retrieve the len of address which listened on
// @return If no error occurs returns a connected socket, Otherwise return INVALID_SOCKET
SOCKET HTTPServer::listen(const char *hostname, const char* service, socklen_t *addrlenp)
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
// @return If no error occurs, Returns 1, If receive buffer
// if empty returns zero, Otherwise returns -1.
int HTTPServer::dataProcess(void)
{
	if (m_recv_buffer.isEmpty()) {
		// No data to process
		return 0;
	}
	string line = "";
	size_t i = 0, lcnt = 0, content_length = 0;
	try {
		for ( ; i < m_recv_buffer.length(); ++i ) {
			char c = m_recv_buffer.at(i);
			line += c;
			// If equals '\n'
			if (m_recv_buffer.at(i) == 0x0a) {
				line = line.substr(0, line.length() - 2);
				if (line.empty()) {
					break;
				}
				lcnt++;
				if (lcnt == 1) {
					/// Process the first line (GET / HTTP/1.1)
					m_method = line.substr(0, line.find_first_of(0x20));
					m_uri = line.substr(line.find_first_of(0x20) + 1, 
						line.find_last_of(0x20) - line.find_first_of(0x20) - 1);
					m_version = line.substr(line.find_last_of(0x20) + 1, 
						line.length() - line.find_last_of(0x20) - 1);
				} else {
					/// Process request headers
					string key = line.substr(0, line.find_first_of(':'));
					string value = line.substr(line.find_first_of(0x20) + 1, 
						line.length() - 1);
					m_requestHeader[key] = value;
					if (Utility::icompare(key, "Content-Length") == 0) {
						content_length = atol(value.c_str());
					}
				}
				line = "";
			}
			
		} // end for
	

		/// Erase \r\n
		while (m_recv_buffer.at(i) == 0x0a || m_recv_buffer.at(i) == 0x0d) {
			++i;
		}
		Chars chars;
		if (content_length != 0 && m_method == "POST") {
			/// Process POST content
			chars = m_recv_buffer.substr(i, content_length);
		}
		if (!chars.isEmpty()) {
			m_recv_buffer = chars;
		} else {
			m_recv_buffer.setEmpty();
		}

	} catch (exception &e) {
		// An exception occurs 
		Logger::Write("HTTPServer.dataProcess", Logger::LOG_ERR, 
			"%s", e.what());
		return -1;
	}
	return 1;
}

// @brief Return all request headers
// @return Return a copy of request header in map
map<string, string> HTTPServer::getAllRequestHeaders(void)
{
	return m_requestHeader;
}

// @brief This method returns request method
// @return m_method
string HTTPServer::method(void)
{
	return m_method;
}

// @brief This method returns request uri
// @return uri 
string HTTPServer::getUri(void)
{
	return m_uri;
}


