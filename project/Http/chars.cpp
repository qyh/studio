#include <cstdlib>
#include <cstring>
#include "chars.h"



// @brief Constructor of class Chars
Chars::Chars()
{
	m_data = NULL;
	m_length = 0;
	m_capacity = 0;
}

// @brief Copy constructor
Chars::Chars(const Chars& rhs):m_data(NULL),m_length(0), m_capacity(0)
{
	
	*this = rhs;
// 	if (this != &rhs) 
// 	{
// 		
// 		m_length = rhs.m_length;
// 		m_capacity = rhs.m_capacity;
// 
// 		if (m_capacity > 0) {
// 			m_data = new char[m_capacity];
// 			if (m_data != NULL) {
// 				memcpy(m_data, rhs.m_data, m_length);
// 			}
// 		}
// 	}
	
}

// @brief Copy constructor
Chars::Chars(const char *rhs)
{
	m_length = 0;
	m_capacity = 0;
	m_data = NULL;
	*this = rhs;
}

// @brief Copy constructor
Chars::Chars(const string& rhs)
{
	m_length = 0;
	m_capacity = 0;
	m_data = NULL;
	*this = rhs.c_str();
}

// @brief Copy constructor
Chars::Chars(char rhs)
{
	m_length = 0;
	m_capacity = 0;
	m_data = NULL;
	
	m_capacity = sizeof(char);
	m_data = new char[m_capacity];

	if (m_data != NULL) {
		m_data[0] = rhs;
		m_length = 1;
	} else {
		m_length = m_capacity = 0;
	}
}


// @brief Assignment operator of Chars
Chars & Chars::operator =(const Chars& rhs)
{
	if (this != &rhs) {
		m_length = rhs.m_length;
		m_capacity = rhs.m_capacity;
		if (m_data != NULL) {
			delete[] m_data;
		}
		if (m_capacity > 0) {
			m_data = new char[m_capacity];
			if (m_data != NULL) {
				memcpy(m_data, rhs.m_data, m_length);
			}
		}
	}
	return *this;
}

// @brief Assignment operator of Chars
Chars & Chars::operator =(const char *rhs)
{
	size_t r_len = strlen(rhs);
	if (m_capacity < r_len) {

		m_capacity = r_len;
		if(m_data != NULL) {
			delete[] m_data;
		}
		m_data = new char[m_capacity];
		if (m_data == NULL) {
			setEmpty();
			return *this;
		}
	}
	memcpy(m_data, rhs, r_len);
	m_length = r_len;

	return *this;
}

// @brief Assignment operator of Chars
Chars & Chars::operator =(const string& rhs)
{
	*this = rhs.c_str();
	return *this;
}

// @brief Assignment operator of Chars
Chars & Chars::operator =(char rhs)
{
	if (isEmpty()){
		m_capacity = sizeof(char);
		m_data = new char[m_capacity];
		if (m_data == NULL) {
			setEmpty();
			return *this;
		}
	}
	m_data[0] = rhs;
	m_length = 1;
	return *this;
}

// @brief Operator +
// @return one copy of Chars
Chars Chars::operator+ (const Chars& rhs)
{
	this->append(rhs.m_data, rhs.length());
	return *this;
}

// @brief Destructor of class Chars
Chars::~Chars()
{
	if (m_data != NULL) {
		delete[] m_data;
	}
	m_length = 0;
	m_capacity = 0;
}

// @brief Whether Chars was empty
// @param void
// @return true if m_length equals 0 or m_data equals NULL, otherwise false 
bool Chars::isEmpty(void)
{
	return m_data == NULL ? true : false;
}

// @brief Empty the Chars and release all memory allocated before
// @param void
// @return void
void Chars::setEmpty(void)
{
	if (m_data != NULL)
		delete[] m_data;
	m_data = NULL;
	m_capacity = 0;
	m_length = 0;
}

// @brief Write data to file
// @param filename, mode
// @return the byte actually written or -1 on error
int Chars::writeFile(const char* filename, ios_base::openmode mode)
{
	ofstream ofs(filename, mode | ios_base::binary);
	if (!ofs.is_open()) {
		return -1;
	}
	ofs.write(m_data, m_length);
	
	// If fail or bad
	if (ofs.fail() || ofs.bad()) {
		ofs.close();
		return -1;
	}

	ofs.close();
	return m_length;
}

// @brief Read data from file specified by filename
// @param filename, mode
// @return the byte actually read or -1 on error
int Chars::readFile(const char* filename, ios_base::openmode mode)
{
	int nRetVal;
#ifdef _WIN32
	struct _stat file_stat;
	nRetVal = _stat(filename, &file_stat);
#else
	struct stat file_stat;
	nRetVal = stat(filename, &file_stat);
#endif
	if (nRetVal < 0) {
		return nRetVal;
	}

	std::ifstream ifs(filename, mode | ios_base::binary);
	if (!ifs.is_open()) {
		return -1;
	}

	if (m_capacity < (size_t)file_stat.st_size) {
		m_capacity = file_stat.st_size;
		m_length = m_capacity;
		delete[] m_data;
		m_data = new char[m_capacity];
		if (m_data == NULL) {
			return -1;
		}

	} else {
		m_length = file_stat.st_size;
	}
	ifs.read(m_data, m_length);
	if (ifs.fail() || ifs.bad()) {
		ifs.close();
		return -1;
	}
	ifs.close();
	return m_length;
}

// @brief Return the length of m_data
// @param void
// @return m_length
size_t Chars::length(void) const
{
	return m_length;
}

// @brief Return the capacity of Chars
// @param void
// @return m_capacity
size_t Chars::capacity(void) const
{
	return m_capacity;
}

// @brief Return the char at index i
// @param i
// @return m_data[i]
char Chars::at(const size_t i)
{
	return m_data[i%m_length];
}

// @brief Return the char at index i
// @param i
// @return m_data[i]
char Chars::operator[](const size_t i)
{
	return at(i);
}

// @brief Append rhs to Chars, r_len specify rhs's length
// @param rhs, r_len
// @return true if successfully, otherwise false
bool Chars::append(const char* rhs, size_t r_len)
{
	
	if (r_len <= 0) {
		return false;
	}
	if (isEmpty()) {
		return this->assign(rhs, r_len);
	}

	if (m_capacity < m_length + r_len) {
		// Allocate temporary memory
		char *tmp = new char[m_length];
		if (tmp == NULL) {
			return false;
		}
		// Save original data 
		memcpy(tmp, m_data, m_length);
		delete[] m_data;

		m_capacity = (m_length + r_len) * 2;
		m_data = new char[m_capacity];
		if (m_data == NULL) {
			delete[] tmp;
			return false;
		}

		memcpy(m_data, tmp, m_length);
		delete[] tmp;
	}

	// Append data to Chars
	memcpy(m_data + m_length, rhs, r_len);
	// Update m_length
	m_length += r_len;
	return true;
}

// @brief Assign rhs to Chars, r_len specify rhs's length
// @param rhs, r_len
// @return true on success, or false on error
bool Chars::assign(const char* rhs, size_t r_len)
{
	
	if (!isEmpty()) {
		setEmpty();
	}
	m_capacity = r_len;
	m_data = new char[m_capacity];
	if (m_data == NULL) {
		return false;
	}

	memcpy(m_data, rhs, r_len);
	m_length = r_len;
	
	return true;
}

// @brief 获取Chars的一部分
// @param beg 开始索引, size 指定大小
// @return 切割后的Chars
Chars Chars::substr(size_t beg, size_t size)
{
	Chars ch;
	if (isEmpty() || beg > m_length ) {
		// Return an empty Chars
		return ch;
	}
	char *s = new char[size];
	if (s == NULL) {
		return ch;
	}

	char *b = m_data + beg;
	if (beg + size > m_length) {
		size = m_length - beg;
	}
	memcpy(s, b, size);
	ch.assign(s, size);
	delete[] s;
	return ch;
}

// @brief Print Chars to standard out
// @param first first index of print, size the size of print
// @return void
void Chars::print(size_t first, size_t size)
{
	if (first > m_length) {
		return ;
	}
	if (first + size > m_length) {
		size = m_length;
	}
	for (size_t i = first; i < size + first; i++) {
		printf("%x ", m_data[i]);
		if (i % 20 == 0 && i != 0) {
			printf("\n");
		}
	}
	printf("\n");
	
}

// @brief Return C style string
// @param void
// @return m_data on C style
const char * Chars::c_str(void) const
{
	if (m_length < m_capacity) {
		m_data[m_length] = 0;
	}
	return m_data;
}

// @brief Find s in Chars
// @param s, s_len
// @return the index of s of -1 when not found
long Chars::find(size_t first, const char *s, size_t s_len)
{
	const int MAX_ARRAY = 1024;
	int next[MAX_ARRAY] = {0};
	size_t i = first;
	long j = 0;
	getNext(s, s_len, next);

	while ( i < m_length ){
		if ( j == -1 || m_data[i] == s[j] ) {
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

// @brief Call by find function
// @param s, s_len, next
// @return void
void Chars::getNext(const char *s, size_t s_len, int * next)
{
	size_t j = 0;
	int k = -1;
	next[0] = -1;
	while ( j < s_len - 1 ){
		if ( k == -1 || s[j] == s[k] ){
			j++;
			k++;
			next[j] = k;
		} else {
			k = next[k];
		}
	}
}








