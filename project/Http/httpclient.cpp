#include "httpclient.h"
#include "utility.h"
// Construct
HTTPClient::HTTPClient()
{
	m_version = "HTTP/1.1";
}

// Destruct
HTTPClient::~HTTPClient()
{

}

// @brief Set HTTP request header
// @param string key, value 
void HTTPClient::setRequestHeader(const string key, const string value)
{
	m_requestHeader[key] = value;
}

// @brief This method return value of header specified by key
// @param string key
// @return If key exists returns the key's value, Otherwise returns null string
string HTTPClient::getRequestHeader(const string key)
{
	map<string, string>::iterator iter;

	if ( (iter = m_requestHeader.find(key)) == m_requestHeader.end()) {
		return "";
	} else {
		return iter->second;
	}
	
}

// @brief Check whether the value specify by key parameter is set
// @param string key
// @return If the value is set returns true, Otherwise returns false.
bool HTTPClient::isRequestHeaderSet(const string key)
{
	map<string, string>::iterator iter;
	if ( (iter = m_requestHeader.find(key)) == m_requestHeader.end()) {
		return false;
	}
	return true;
}

// @brief This method return all response headers
// @return All headers represented by map<string, string>
map<string, string> HTTPClient::getAllResponseHeaders(void)
{
	return m_responseHeader;
}

// @brief Get response specified by key
// @param key The header's key
// @return If the key specify by parameter 'key' exists returns the mapping value,
// Otherwise returns a null string.
string HTTPClient::getResponseHeader(const string key)
{
	map<string, string>::iterator iter;
	if ((iter = m_responseHeader.find(key)) == m_responseHeader.end()) {
		return "";
	} else {
		return iter->second;
	}
}

// @brief The status of response
// @return The status code
string HTTPClient::status(void)
{
	return m_status;
}

// @brief The version of HTTP
// @return returns the version of HTTP represented by string
string HTTPClient::version(void)
{
	return m_version;
}

// @brief decode the data which receives 
// @return If no error occurs returns receive data which doesn't contain the HTTP header,
// Otherwise -1 is returns
int HTTPClient::decodeHttpData(void)
{
	// If No data was receive 
	if (m_recv_buffer.length() <= 0)
		return -1;

	// Decode HTTP data
	Chars http_data;
	string line;
	int line_count = 0;
	size_t content_length = 0;
	size_t i = 0;
	bool is_chunked = false;
	/**
	 * Read HTTP header
	 */
	for ( i = 0; i < m_recv_buffer.length(); ++i ) 
	{
		line += m_recv_buffer.at(i);
		if (line[line.length() - 1] == 0x0a) {// \n
			line_count ++;
			// Erase \r\n.
			line = line.substr(0, line.length() - 2);
			if (line.empty()) {
				// Empty line: headers end
				break;
			}
			if (line_count == 1) {
				// The first line: HTTP/1.1 200 OK
				// 0x20: ' '
				m_version = line.substr(0, line.find_first_of(0x20));
				m_status = line.substr(line.find_first_of(0x20) + 1,
					line.find_last_of(0x20) - line.find_first_of(0x20) - 1); 
			} else {
				/// Headers 
				std::string key = line.substr(0, line.find_first_of(':'));
				std::string value = line.substr(line.find_first_of(':') + 2, 
					line.length() - line.find_first_of(':') - 2);
				m_responseHeader[key] = value;
				// Whether exists 'Content-Length' field.
				if (Utility::icompare(key, "Content-Length") == 0) {
					content_length = atol(value.c_str());
				}
				// Is chunked ?
				if (Utility::icompare(key, "Transfer-Encoding") == 0
					&& Utility::icompare(value, "chunked") == 0) {
						is_chunked = true;
				}
			}
			// Empty line
			line = "";
		} // end if
	}  // end for()

	/// Erase \r\n
	for ( ; i < m_recv_buffer.length(); ++i ) {
		if (m_recv_buffer.at(i) == 0x0d || m_recv_buffer.at(i) == 0x0a)
			continue;
		break;
	}

	/**
	 * Read HTTP content
	 */
	if (content_length != 0) 
	{
		http_data = m_recv_buffer.substr(i, content_length);
		i += content_length;
	}
	else 
	{
		// Is chunked ?
		if (is_chunked) {
			// Process chunked data
			/// Read Content-Length flag
			line = "";
			for ( ; i < m_recv_buffer.length(); ++i ) {
				line += m_recv_buffer.at(i);
				if (line[line.length() - 1] == 0x0a) {
					content_length = Utility::hexToDecimal((line.substr(0, line.length() - 2)).c_str());
					break;
				}
			}
				
			long p = 0;
			while (true) {
				// Find EOF flag
				p = m_recv_buffer.find(p, "0\r\n\r\n", 5);
				if (p == -1)
					break;
				if (p <= (long)i) {
					p = i;
					continue;
				}
				break;
			}
			
			if (p != -1) {
                i += 1;
				http_data = m_recv_buffer.substr(i, p - i);
				i += p - i;
			} else {
				// Does not found the end flag "0\r\n\r\n"
 				http_data = m_recv_buffer.substr(++i, content_length);
 				i += content_length;
			}
		} // end if(is_chunked)
	}
	m_recv_buffer = http_data;
	// Return receive length in bytes
	return ++i;
}

// @brief Send HTTP get request
// @param string uri The request uri
// @return If no error occurs returns the number of receive in bytes,
// Otherwise -1 is returns
int HTTPClient::get( string uri )
{
	string str;
	m_method = "GET";
	str += "GET " + uri + " " + m_version;
	str += "\r\n";
	str += "Host: " + m_host;
	str += "\r\n";
	map<string, string>::iterator iter = m_requestHeader.begin();
	while (iter != m_requestHeader.end()) {
		str += iter->first + ": ";
		str += iter->second;
		str += "\r\n";
		++iter;
	}
	// Headers end
	str += "\r\n";

	if (!isBlocking()) {
		setBlocking();
	}

	// Set receive and send timeout to 5 seconds
	int nTimeout = 5000;
	if (m_host == "127.0.0.1") {
		nTimeout = 100;
	}
	setRcvTimeout(nTimeout);
	setSndTimeout(nTimeout);

	int n = this->send(str.c_str(), str.length());
	if (n == -1) {
		return n;
	}
	//this->shutdown(SHUT_WD);

	/**
	 * Receive response data
	 */

	// Receive all response data to socket buffer including HTTP headers
	while ( this->recv(1024) > 0 )
		;
	return decodeHttpData();
#if 0
	// If No data was receive 
	if (m_recv_buffer.length() <= 0)
		return -1;

	// Decode HTTP data
	Chars http_data;
	string line;
	int line_count = 0;
	size_t content_length = 0;
	size_t i = 0;
	bool is_chunked = false;
	/**
	 * Read HTTP header
	 */
	for ( i = 0; i < m_recv_buffer.length(); ++i ) 
	{
		line += m_recv_buffer.at(i);
		if (line[line.length() - 1] == 0x0a) {// \n
			line_count ++;
			// Erase \r\n.
			line = line.substr(0, line.length() - 2);
			if (line.empty()) {
				// Empty line: headers end
				break;
			}
			if (line_count == 1) {
				// The first line: HTTP/1.1 200 OK
				// 0x20: ' '
				m_version = line.substr(0, line.find_first_of(0x20));
				m_status = line.substr(line.find_first_of(0x20) + 1,
					line.find_last_of(0x20) - line.find_first_of(0x20) - 1); 
			} else {
				/// Headers 
				std::string key = line.substr(0, line.find_first_of(':'));
				std::string value = line.substr(line.find_first_of(':') + 2, 
					line.length() - line.find_first_of(':') - 2);
				m_responseHeader[key] = value;
				// Whether exists 'Content-Length' field.
				if (Utility::icompare(key, "Content-Length") == 0) {
					content_length = atol(value.c_str());
				}
				// Is chunked ?
				if (Utility::icompare(key, "Transfer-Encoding") == 0
					&& Utility::icompare(value, "chunked") == 0) {
						is_chunked = true;
				}
			}
			// Empty line
			line = "";
		} // end if
	}  // end for()

	/// Erase \r\n
	for ( ; i < m_recv_buffer.length(); ++i ) {
		if (m_recv_buffer.at(i) == 0x0d || m_recv_buffer.at(i) == 0x0a)
			continue;
		break;
	}

	/**
	 * Read HTTP content
	 */
	if (content_length != 0) 
	{
		http_data = m_recv_buffer.substr(i, content_length);
		i += content_length;
	}
	else 
	{
		// Is chunked ?
		if (is_chunked) {
			// Process chunked data
			/// Read Content-Length flag
			line = "";
			for ( ; i < m_recv_buffer.length(); ++i ) {
				line += m_recv_buffer.at(i);
				if (line[line.length() - 1] == 0x0a) {
					content_length = Utility::hexToDecimal((line.substr(0, line.length() - 2)).c_str());
					break;
				}
			}
				
			long p = 0;
			while (true) {
				// Find EOF flag
				p = m_recv_buffer.find(p, "0\r\n\r\n", 5);
				if (p == -1)
					break;
				if (p <= (long)i) {
					p = i;
					continue;
				}
				break;
			}
			
			if (p != -1) {
                i += 1;
				http_data = m_recv_buffer.substr(i, p - i);
				i += p - i;
			} else {
				// Does not found the end flag "0\r\n\r\n"
 				http_data = m_recv_buffer.substr(++i, content_length);
 				i += content_length;
			}
		} // end if(is_chunked)
	}
	m_recv_buffer = http_data;
	// Return receive length in bytes
	return ++i;
#endif
}

// @brief Send post request
// @param string uri the request uri
// @return If no error occurs returns the number of receive data in bytes,
// Otherwise -1 is returns
int HTTPClient::post( string uri, Chars &body )
{
	string str;
	m_method = "POST";
	str += "POST " + uri + " " + m_version;
	str += "\r\n";
	str += "Host: " + m_host;
	str += "\r\n";
	map<string, string>::iterator iter = m_requestHeader.begin();
	while (iter != m_requestHeader.end()) {
		str += iter->first + ": ";
		str += iter->second;
		str += "\r\n";
		++iter;
	}
	// Set 'Content-length'
	str += "Content-Length: ";
	char buf[25];
	snprintf(buf, 25, "%ld", body.length());
	str += buf;
	str += "\r\n";

	// Headers end
	str += "\r\n";

	Chars data;
	data.assign(str.c_str(), str.length());
	data.append(body.c_str(), body.length());

	if (!isBlocking()) {
		setBlocking();
	}

	// Set receive and send timeout to 5 seconds
	int nTimeout = 5000;
	if (m_host == "127.0.0.1") {
		nTimeout = 100;
	}
	setRcvTimeout(nTimeout);
	setSndTimeout(nTimeout);

	int n = this->send(data.c_str(), data.length());
	if (n == -1) {
		return n;
	}
	//this->shutdown(SHUT_WD);

	/**
	 * Receive response data
	 */

	// Receive all response data to socket buffer including HTTP headers
	while ( this->recv(1024) > 0 )
		;
	return decodeHttpData();
}


