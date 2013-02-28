#ifndef __LOGGER_H
#define __LOGGER_H

#include <fstream>
#include <iostream>
#include <string>
#include "fast_mutex.h"

using std::ios_base;
using std::string;
using std::ifstream;
using std::ofstream;
using namespace tthread;

class Logger;

class Logger
{
public:
	// 日志级别
	typedef enum {
		LOG_ERR = 3,
		LOG_WARNING = 4,
		LOG_NOTICE = 5,
		LOG_INFO = 6,
		LOG_DEBUG = 7
	}LOG_LEVEL;

	// @brief 初始化日志信息,打开日志文件
	// @param logfile 指定日志文件名, bufsize 日志缓冲区大小
	// @return 成功返回true, 失败返回false
	static bool Initialize(const char *logfile, size_t bufsize);


	// @brief 将日志信息写入到缓冲区
	// @param ident 加到每条日志前的信息(一般为程序名), 
	// level 日志级别, fmt 格式化字符串
	// @return 成功返回true, 失败返回 false 
	static bool Write(const char *ident, LOG_LEVEL level, const char* fmt, ...);

	// @brief 将缓冲区数据写入到文件并，清空日志缓冲区
	// @param void
	// @return void
	static void Flush(void);

	// @brief 清除未写入的数据，关闭打开的文件
	static void Uninit(void);

private:
	static std::string m_text;		// 日志缓冲
	static fast_mutex  m_text_lock; // 缓冲锁
	static std::ofstream m_logfile; // 日志文件
	static size_t		 m_buffer_size; // 缓冲区大小
	static bool m_isInit;
};

#endif


