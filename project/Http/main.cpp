#include <iostream>
#include <string>
#include <exception>

#include "http.h"
#include "chars.h"
#include "image.h"
#include "logger.h"
#include "httpserver.h"
#include "utility.h"
#include "tcpclient.h"
#include "tcpserver.h"
#include "httpclient.h"

#ifdef _WIN32
// Using pthread
#include <pthread.h>
#include <semaphore.h>
#include <sched.h>
#endif 

using namespace std;
using std::string;

void CallBack(void *param) 
{
	HTTPServer *p = (HTTPServer *)param;
	p->shutdown(SHUT_WR);
	cout << "callback:\n";
	map<string, string> reqs = p->getAllRequestHeaders();
	map<string, string>::iterator iter = reqs.begin();
	Logger::Write("Callback:", Logger::LOG_INFO, "come to callback now");
	Logger::Flush();
	cout << p->method() << " " << p->getUri() 
		<< " " << p->version() << endl;
	while (iter != reqs.end()) {
		cout << iter->first << ": " << iter->second << endl;
		++iter;
	}
	if (p->length() > 0) {
		char *pBuf = new char[p->length() + 1];
		memcpy(pBuf, p->c_str(), p->length());
		pBuf[p->length()] = 0;
		cout << "content: " << pBuf;
		delete pBuf;
	}
#ifdef _WIN32
	struct sockaddr_in addr= *((struct sockaddr_in*)p->getsockaddr());
	cout << inet_ntoa(addr.sin_addr) << endl;
	//struct hostent * hosts = gethostbyaddr((const char*)(p->getremoteaddr()), p->getremoteaddrlen(), p->getsockfamily());
#else
	struct hostent * hosts = gethostbyaddr((p->getremoteaddr()), p->getremoteaddrlen(), p->getsockfamily());
#endif
	/*
	if (hosts == NULL) {
			cout << "hosts is NULL" << endl;
			return;
		}
		cout << "h_name: " << hosts->h_name << endl
			<< "h_addrType: " << hosts->h_addrtype << endl
			<< "h_length: " << hosts->h_length << endl;
		while (*hosts->h_addr_list) {
			cout << *hosts->h_addr_list << endl;
		}
	*/
	
}

void * PthreadProc(void *param)
{
	cout << "Sub thread..." << endl;
	return NULL;
}

void println(const char* s, ...)
{
	va_list ap;
	char *pBuf = NULL;
	
	va_start(ap, s);
	

#ifdef _WIN32
	int bufsize = _vscprintf(s, ap) + 1;
	pBuf = (char *)calloc(1, bufsize);
	vsprintf_s(pBuf, bufsize, s, ap);
#else
	int bufsize = vasprintf(&pBuf, s, ap) + 1;
	vsnprintf(pBuf, bufsize, s, ap);
#endif 
	va_end(ap);
	
	printf("%s\n", pBuf);
	free(pBuf);
}

typedef struct _Data{
	string remoteAddr;
	Chars  data;
}Data;

int main(int argc, char ** argv) 
{
#if 0
	/**
	 * Just for normal testing
	 */
	string str = "hello world";
	Chars chars = "hello world";
	try {
		string sub = str.substr(0, 20);
		Chars s = chars.substr(0, 10);
		cout << s.length() << endl;
		cout << s.c_str() << endl;

	} catch(exception &e) {
		cout << e.what() << endl;
	}
#endif 

#if 0
	// Using pthread
// 	pthread_t tid;
// 	pthread_create(&tid, NULL, PthreadProc, NULL);
// 
// 	pthread_exit(&tid);
	HTTPClient cli;
	cli.connect("127.0.0.1", "80");
	cli.get("/test.php");
	char *s = new char[cli.length() + 1];
	memcpy(s, cli.c_str(), cli.length());
	s[cli.length()] = 0;
	cout << s;

#endif 

#if 1

	Chars chars;

	cout << "init log:" << Logger::Initialize("log.txt", 10) << endl;
	HTTPServer tcpser;
	HTTPClient tcpcli;
	cout << "bind:" << tcpser.bind("127.0.0.1", "8080", CallBack) << endl;
	cout << tcpcli.connect("127.0.0.1", "8080") << endl;
	string str;
	str = "Hello, I am the body !";
	cout << "content length: " << str.length() << endl;
	Chars body;
	body.append(str.c_str(), str.length());
	
	tcpcli.setSndTimeout(1);
	tcpcli.setRcvTimeout(1);
	tcpcli.post("/", body);
	//tcpcli.recv(1024);
	//tcpcli.shutdown(SD_BOTH);
	//cout << (tcpcli.c_str()) << endl;
	for ( ;; ) 
	{
		Utility::sleepms(1000);
// 		TCPClient t;
// 		t.setSndTimeout(500);
// 		t.setRcvTimeout(500);
// 		t.connect("127.0.0.1", "8080");
// 		t.send(str.c_str(), str.length());
		//t.recv(1024);
		//t.shutdown(SD_BOTH);
		//cout << t.c_str() << endl;
		break;
	}
	Utility::sleepms(10000);
	cout << "stop:" << tcpser.stop() << endl;
	Logger::Uninit();
#endif
	return 0;
}

