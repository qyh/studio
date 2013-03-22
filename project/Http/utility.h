#ifndef _STR_UTIL_H
#define _STR_UTIL_H

#ifdef	_WIN32
#include	<windows.h>
#define strcasecmp stricmp
#define atoll _atoi64
#pragma warning(disable:4996)
#else 
 #include <unistd.h>
#endif

#include <string>
#include <map>
#include <vector>
#include <list>
#include <stdarg.h>
#include <stdlib.h>
using namespace std;

#ifndef MAXBUFF
#define  MAXBUFF 4096
#else

#endif



class Utility{
public:
	// @brief Sleep for ms seconds
	// @param size_t ms specify how long to sleep
	// @return 
	static int sleepms(size_t ms);

	// @brief Return current date time
	// @return current date time 
	static std::string currentDateTime(void);

	// @brief Compare string lhs and rhs ignores case
	// @param string lhs, rhs The string to be compare
	// @return If lhs equals rhs returns zero, if lhs > rhs returns 1
	// Otherwise returns -1.
	static int icompare(std::string lhs, std::string rhs);

	// @brief Hexadecimal to decimal
	// @param hexa
	// @return integer represented with Hexadecimal
	static int hexToDecimal(const char *hexa);

	// @brief Formated output to the standard output stream
	// @param s Format control
	// @return Returns the number of characters printed, or a 
	// negative value if an error occurs.
	static int println(const char* s, ...);

	// Split string into vector by substr specified by sep
	static vector<string> split( const string & str, const string & sep );

	static void split( const string& str, const string & sep, vector< string > & v );

	// Get string from src between begin and end
	static string whthin( const string& src, const string& begin, const string& end );

	// Kmp find
	static int find(const char * src, const char *s);

	static int find(const unsigned char * src, size_t src_len, const unsigned char *s, size_t s_len);

	// Snprintf
	static int snprintf( char *str, size_t size, const char *format, ... );

	// Trip
	static string trip( const char * str );

	// ltrim
	static string ltrim( const char *str );

	// rtrim
	static string rtrim( const char *str );

	// trim
	static string trim( const char * str );

	// check whether src start with sub
	static bool startWith( const char *src, const char *sub );

	// Returns the string representation of the value argument.
	static string toString( int value );

	static string toString( long value );

	static string toString( double value );

	static string toString( float value );

	static string toString( long long value );

	static long long parseLong( const char *val );

	static double parseDouble( const char * val );

	/// Extract uri from url
	static string extractUri( const std::string& url );

	/// Extract port from url
	static string extractPort( const std::string& url );

	/// Extract parameter from url
	static string extractParameter( const std::string& url );

	/// Extract ip/host from url
	static string extractHost( const std::string& url );

	/// ToUpper
	static string toupper( const string& str );

	/// ToLower
	static string tolower( const string& str );
private:
	static void getNext(const char *s, int * next);

	static void getNext(const unsigned char *s, size_t s_len, int * next);
private:
	static const int MAX_ARRAY = 1024;
};

#endif 




