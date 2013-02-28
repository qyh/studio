#include <cstdio>
#include <stdlib.h>
#include <cmath>
#include <ctime>

#ifndef	_WIN32
#include	<string.h>
#else
#include <sys/timeb.h>
#endif

#include "utility.h"


// @brief Return current date time
// @return current date time 
std::string Utility::currentDateTime(void)
{
	char pTime[MAXBUFF];
	time_t t0;
#ifndef _WIN32
	tm localtm;
	tm * tm0=&localtm;
#else
	tm *tm0;
#endif
	t0=time(0);
#ifdef  _WIN32
	tm0=localtime(&t0);
#else
	localtime_r(&t0,&localtm);
#endif
	//sprintf(pTime,"%04d-%02d-%02d %02d:%02d:%02d",tm0->tm_year+1900,
	sprintf(pTime,"%04d-%02d-%02d %02d:%02d:%02d",tm0->tm_year+1900,
		tm0->tm_mon+1,tm0->tm_mday,tm0->tm_hour,tm0->tm_min,
		tm0->tm_sec);
	return string(pTime);
}

// @brief Sleep for ms seconds
// @param size_t ms specify how long to sleep
// @return 
int Utility::sleepms(size_t ms)
{
#ifdef _WIN32
	return SleepEx(ms, TRUE);
#else
	return usleep(ms * 1000);
#endif
}


// Split string into vector by substr specified by sep
vector<string> Utility::split(const string & str, const string & sep)
{
	vector<string> strVector;
	size_t startIndex = 0;
	size_t index = -1;
	while ( true ) {
		index = str.find_first_of(sep, startIndex);
		if (index == string::npos) {
			break;
		}
		string s = str.substr(startIndex, index - startIndex);
		if (!s.empty())
			strVector.push_back(s);
		startIndex = index + sep.length();
	}

	string endstr = str.substr(startIndex, str.length() - startIndex);
	if (!endstr.empty())
		strVector.push_back(endstr);
	
	return strVector;
}

void Utility::split(const string & str, const string & sep, vector< string > & strVector)
{
	size_t startIndex = 0;
	size_t index = -1;
	while ( true ) {
		index = str.find_first_of(sep, startIndex);
		if (index == string::npos) {
			break;
		}
		string s = str.substr(startIndex, index - startIndex);
		if (!s.empty())
			strVector.push_back(s);
		startIndex = index + sep.length();
	}

	string endstr = str.substr(startIndex, str.length() - startIndex);
	if (!endstr.empty())
		strVector.push_back(endstr);

}

/************************************************************************/
/*  Get string from src between beginstr and endstr                           */
/************************************************************************/
string Utility::whthin( const string& src, const string& beginstr, const string& endstr )
{
	string str;
	size_t start = 0, end = 0;
	start = src.find_first_of(beginstr, start);
	if ( start == string::npos ) {
		return "";
	}
	if ( (end = src.find_first_of( endstr, start ) ) == string::npos ) {
		return "";
	}
	str = src.substr( start + 1, end - start - 1 );
	return str;
}
// Kmp find
int Utility::find(const char * str, const char *p)
{
	int next[MAX_ARRAY] = {0};
	size_t i = 0;
    long j = 0;
	getNext(p, next);

	while ( i < strlen(str) ){
		if ( j == -1 || str[i] == p[j] ) {
			i++;
			j++;
		} else {
			j = next[j];
		}

		if ( j == (long)strlen(p) ) {
			return i - strlen(p);
		}
	}

	return -1;
}

int Utility::find(const unsigned char * src, size_t src_len, const unsigned char *p, size_t s_len)
{
	int next[MAX_ARRAY] = {0};
	size_t i = 0;
    long j = 0;
	getNext(p, s_len, next);

	while ( i < src_len ){
		if ( j == -1 || src[i] == p[j] ) {
			i++;
			j++;
		} else {
			j = next[j];
		}

		if ( j == (long)s_len ) {
			return i - s_len;
		}
	}

	return -1;
}

// check whether src start with sub
bool Utility::startWith( const char *src, const char *sub )
{
	return Utility::find( src, sub ) == 0 ? true : false;
}

void Utility::getNext(const char *p, int *next)
{
	size_t j = 0;
	int k = -1;
	next[0] = -1;
	while ( j < strlen(p) - 1 ){
		if ( k == -1 || p[j] == p[k] ){
			j++;
			k++;
			next[j] = k;
		} else {
			k = next[k];
		}
	}
}

void Utility::getNext(const unsigned char *p, size_t s_len, int * next)
{
	size_t j = 0;
	int k = -1;
	next[0] = -1;
	while ( j < s_len - 1 ){
		if ( k == -1 || p[j] == p[k] ){
			j++;
			k++;
			next[j] = k;
		} else {
			k = next[k];
		}
	}
}

// Returns the string representation of the value argument.
string Utility::toString( long value )
{
	char buf[MAXBUFF];
	memset(buf, 0, MAXBUFF);
	snprintf(buf, MAXBUFF, "%ld", value );
	return string(buf);
}

string Utility::toString( int value )
{
	char buf[MAXBUFF];
	memset(buf, 0, MAXBUFF);
	snprintf(buf, MAXBUFF, "%d", value );
	return string(buf);
}

string Utility::toString( double value )
{
	char buf[MAXBUFF];
	memset(buf, 0, MAXBUFF);
	snprintf(buf, MAXBUFF, "%lf", value );
	return string(buf);
}

string Utility::toString( float value )
{
	char buf[MAXBUFF];
	memset(buf, 0, MAXBUFF);
	snprintf(buf, MAXBUFF, "%f", value );
	return string(buf);
}

string Utility::toString( long long value )
{
	char buf[MAXBUFF];
	memset(buf, 0, MAXBUFF);
	snprintf(buf, MAXBUFF, "%lld", value);
	return string(buf);
}

int Utility::snprintf( char *str, size_t size, const char *format, ... ) {

	int iret = -1;
	va_list		ap;
	va_start(ap, format);
#ifdef _WIN32	
	iret = vsprintf_s(str, size, format, ap);
#else
	iret = vsnprintf(str, size, format, ap);
#endif
	va_end(ap);
	return iret;
}

long long Utility::parseLong( const char *value )
{
	return atoll(value);
}

double Utility::parseDouble( const char * val )
{
	return atof(val);
}

string Utility::trip( const char * str )
{
	string s;
	int i = 0;
	while (str[i] != '\0') {
		if (str[i] != ' ' && str[i] != '\t') {
			s += str[i];
		}
		i++;
	}
	return s;
}

// ltrim
string Utility::ltrim( const char *str )
{
	
	int i = 0;
	while ( (str[i] == ' ' || str[i] == '\t') && str[i] != '\0' ) {
		i++;
	}
	
	return string((char *)&str[i]);
	
}

// rtrim
string Utility::rtrim( const char *str )
{
	int len = strlen(str) - 1;
	char *s = (char *)str;
	while ((len >= 0) &&  (s[len] == ' ' || s[len] == '\t') ) {
		len--;
	}
	
	return string(s).substr(0, len);
}

// trim
string Utility::trim( const char * str )
{
	return rtrim(ltrim(str).c_str());
}

/// ToUpper
string Utility::toupper( const string& str )
{
	std::string r;
	for (size_t i = 0; i < str.size(); ++i)
	{
		if (str[i] >= 'a' && str[i] <= 'z')
			r += (char)(str[i] - 32);
		else
			r += str[i];
	}
	return r;
}

string Utility::tolower( const string& str )
{
	std::string r;
	for (size_t i = 0; i < str.size(); ++i)
	{
		if (str[i] >= 'A' && str[i] <= 'Z')
			r += str[i] | 32;
		else
			r += str[i];
	}
	return r;
}

string Utility::extractHost( const std::string& url )
{
	/// http://www.baidu.com:80/uri?username=user&password=pwd
	/// www.baidu.com
	/// www.baidu.com/
	/// www.baidu.com/url
	///	www.baidu.com/uri?username=user&password=pwd
	string str = url;
	int iret = find(str.c_str(), "//");
	if (iret > 0) {
		str = url.substr(iret + strlen("//"), url.length() - iret - strlen("//"));
	}
	iret = find(str.c_str(), ":");
	if (iret > 0) {
		str = str.substr(0, iret);
		return str;
	}
	iret = find(str.c_str(), "/");
	if (iret > 0) {
		return str.substr(0, iret);
	} else {
		return str.substr(0, str.length());
	}

	
}

string Utility::extractPort( const std::string& url )
{
	string str = url;
	int n;

	int iret = find(str.c_str(), "//");
	if (iret > 0) {
		str = url.substr(iret + strlen("//"), url.length() - iret - strlen("//"));
	}
	iret = find(str.c_str(), ":");
	if (iret > 0) {
		n = find(str.c_str(), "/");
		if (n > 0) {
			return str.substr(iret + 1, n - iret - 1);
		} else {
			return str.substr(iret + 1, str.length() - iret - 1);
		}
	}
	return "80";
}

string Utility::extractUri( const std::string& url )
{
	string str = url;
	int n;
	int iret = find(str.c_str(), "//");
	if (iret > 0) {
		str = url.substr(iret + strlen("//"), url.length() - iret - strlen("//"));
	}
	iret = find(str.c_str(), "/");
	if (iret > 0) {
		n = find(str.c_str(), "?");
		if (n < 0) {
			return "/";
		}
		return str.substr(iret, n - iret);
	}

	return "/";
}

string Utility::extractParameter( const std::string& url )
{
	/// http://www.baidu.com:80/uri?username=user&password=pwd
	/// www.baidu.com
	/// www.baidu.com/
	/// www.baidu.com/url
	///	www.baidu.com/uri?username=user&password=pwd
	string str = url;
	int iret = find(str.c_str(), "//");
	if (iret > 0) {
		str = url.substr(iret + strlen("//"), url.length() - iret - strlen("//"));
	}
	iret = find(str.c_str(), "?");
	if (iret > 0) {
		return str.substr(iret + 1, str.length() - iret - 1);
	}

	return "";
}

// @brief Compare string lhs and rhs ignores case
// @param string lhs, rhs The string to be compare
// @return If lhs equals rhs returns zero, if lhs > rhs returns 1
// Otherwise returns -1.
int Utility::icompare(std::string lhs, std::string rhs)
{
#ifdef _WIN32
	return _strnicmp(lhs.c_str(), rhs.c_str(), lhs.length());
#else
	//return strnicmp(lhs.c_str(), rhs.c_str(), lhs.length());
    int ch1, ch2, i = 0;
    do {
        if (((ch1 = (unsigned char)((lhs[i]))) >= 'A') && (ch1 <= 'Z'))
            ch1 += 0x20;
        if (((ch2 = (unsigned char)((rhs[i++]))) >= 'A') && (ch2 <= 'Z'))
            ch2 += 0x20;
        
    } while ( ch1 && (ch1 == ch2) );
    return (ch1 - ch2);
#endif
}

// @brief Hexadecimal to decimal
// @param hexa
// @return integer represented with Hexadecimal
int Utility::hexToDecimal(const char *hexa)
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

// @brief Formated output to the standard output stream
// @param s Format control
// @return Returns the number of characters printed, or a 
// negative value if an error occurs.
int Utility::println(const char* s, ...)
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

	int n = printf("%s\n", pBuf);
	free(pBuf);
	return n;
}


