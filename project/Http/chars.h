#ifndef __CHARS_H
#define __CHARS_H

#include <iostream>
#include <fstream>
#include <string>

using std::ios_base;
using std::ifstream;
using std::ofstream;
using std::string;

#ifdef _WIN32
#include <sys/stat.h>
#else
#include <sys/stat.h>
#endif

class Chars;

class Chars
{
public:
	// @brief Constructor of class Chars
	Chars();

	// @brief Copy constructor
	Chars(const Chars& rhs);
	Chars(const char* rhs);
	Chars(const string& rhs);
	Chars(char rhs);

	// @brief Assignment operator of Chars
	Chars & operator= (const Chars& rhs);
	Chars & operator= (const char *rhs);
	Chars & operator= (const string& rhs);
	Chars & operator= (char rhs);

	// @brief Operator +
	// @return one copy of Chars
	Chars operator+ (const Chars& rhs);
	Chars operator+ (const char* rhs);
	Chars operator+ (const string& rhs);
	Chars operator+ (char rhs);

	// @brief Operator +=
	// @return the reference of Chars
	Chars & operator+= (const Chars& rhs);
	Chars & operator+= (const char* rhs);
	Chars & operator+= (const string& rhs);
	Chars & operator+= (char rhs);

	// @brief Destructor of class Chars
	~Chars();

	// @brief Write data to file
	// @param filename, mode:(ios_base::binary, ios_base::in
	// @return the byte actually written or -1 on error
	int writeFile(const char* filename, ios_base::openmode _Mode = ios_base::out);

	// @brief Read data from file specified by filename
	// @param filename, mode:(ios_base::binary, ios_base::app, ios_base::out
	// @return the byte actually read or -1 on error
	int readFile(const char* filename, ios_base::openmode _Mode = ios_base::in);

	// @brief Whether Chars was empty
	// @param void
	// @return true if m_length equals 0 or m_data equals NULL, otherwise false 
	bool isEmpty(void);

	// @brief Empty the Chars and release all memory allocated before
	// @param void
	// @return void
	void setEmpty(void);

	// @brief Return the length of m_data
	// @param void
	// @return m_length
	size_t length(void) const;

	// @brief Return the capacity of Chars
	// @param void
	// @return m_capacity
	size_t capacity(void) const;

	// @brief Return the char at index i
	// @param i
	// @return m_data[i]
	char at(const size_t i);

	// @brief Return the char at index i
	// @param i
	// @return m_data[i]
	char operator[](const size_t i);

	// @brief Append rhs to Chars, r_len specify rhs's length
	// @param rhs, r_len
	// @return true if successfully, otherwise false
	bool append(const char* rhs, size_t r_len);

	// @brief Assign rhs to Chars, r_len specify rhs's length
	// @param rhs, r_len
	// @return true on success, or false on error
	bool assign(const char* rhs, size_t r_len);

	// @brief 获取Chars的一部分
	// @param beg 开始索引, size 指定大小
	// @return 切割后的Chars
	Chars substr(size_t beg, size_t size);

	// @brief Return C style string
	// @param void
	// @return m_data on C style
	const char * c_str(void) const;

	// @brief Find s in Chars
	// @param s, s_len
	// @return the index of s of -1 when not found
	long find(size_t first, const char *s, size_t s_len);

	// @brief Print Chars to standard out
	// @param first first index of print, size the size of print
	// @return void
	void print(size_t first, size_t size);
	

	// 
	// Iterator of Chars
	//
	class iterator
	{
	public:

		Chars & m_data;
	};

private:
	// @brief Call by find function
	// @param s, s_len, next
	// @return void
	void getNext(const char *s, size_t s_len, int * next);
	
private:
	// The real data of Chars
	char * m_data;

	// The length of Chars
	size_t m_length;

	// The capacity of Chars
	size_t m_capacity;
};

#endif
