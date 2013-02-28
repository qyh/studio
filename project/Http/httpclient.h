#ifndef __HTTPCLIENT_H
#define __HTTPCLIENT_H

#include <map>
#include <string>
#include "tcpclient.h"

using std::string;
using std::map;

class TCPClient;

class HTTPClient : public TCPClient
{
public:
	// Construct
	HTTPClient();

	// Destruct
	~HTTPClient();

	// @brief Send get request
	// @param string uri The request uri
	// @return If no error occurs returns the number of receive in bytes,
	// Otherwise -1 is returns
	int get( string uri = "/" );

	// @brief Send post request
	// @param string uri the request uri
	// @return If no error occurs returns the number of receive data in bytes,
	// Otherwise -1 is returns
	int post( string uri, Chars &body );

	// @brief Set HTTP request header
	// @param string key, value 
	void setRequestHeader(const string key, const string value);

	// @brief This method return value of header specified by key
	// @param string key
	// @return If key exists returns the key's value, Otherwise returns null string
	string getRequestHeader(const string key);

	// @brief Check whether the value specify by key parameter is set
	// @param string key
	// @return If the value is set returns true, Otherwise returns false.
	bool isRequestHeaderSet(const string key);

	// @brief This method return all response headers
	// @return All headers represented by map<string, string>
	map<string, string> getAllResponseHeaders(void);

	// @brief Get response specified by key
	// @param key The header's key
	// @return If the key specify by parameter 'key' exists returns the mapping value,
	// Otherwise returns a null string.
	string getResponseHeader(const string key);

	// @brief The status of response
	// @return The status code
	string status(void);

	// @brief The version of HTTP
	// @return returns the version of HTTP represented by string
	string version(void);
private:
	// @brief decode the data which receives 
	// @return If no error occurs returns receive data which doesn't contain the HTTP header,
	// Otherwise -1 is returns
	int decodeHttpData(void);

protected:
	// HTTP version
	string m_version;

	// HTTP response status
	string m_status;

	// Request uri
	string m_uri;

	// Request method
	string m_method;

	// Request header
	map<string, string> m_requestHeader;

	// Response header
	map<string, string> m_responseHeader;
};

#endif


