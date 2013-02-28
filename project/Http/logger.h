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
	// ��־����
	typedef enum {
		LOG_ERR = 3,
		LOG_WARNING = 4,
		LOG_NOTICE = 5,
		LOG_INFO = 6,
		LOG_DEBUG = 7
	}LOG_LEVEL;

	// @brief ��ʼ����־��Ϣ,����־�ļ�
	// @param logfile ָ����־�ļ���, bufsize ��־��������С
	// @return �ɹ�����true, ʧ�ܷ���false
	static bool Initialize(const char *logfile, size_t bufsize);


	// @brief ����־��Ϣд�뵽������
	// @param ident �ӵ�ÿ����־ǰ����Ϣ(һ��Ϊ������), 
	// level ��־����, fmt ��ʽ���ַ���
	// @return �ɹ�����true, ʧ�ܷ��� false 
	static bool Write(const char *ident, LOG_LEVEL level, const char* fmt, ...);

	// @brief ������������д�뵽�ļ����������־������
	// @param void
	// @return void
	static void Flush(void);

	// @brief ���δд������ݣ��رմ򿪵��ļ�
	static void Uninit(void);

private:
	static std::string m_text;		// ��־����
	static fast_mutex  m_text_lock; // ������
	static std::ofstream m_logfile; // ��־�ļ�
	static size_t		 m_buffer_size; // ��������С
	static bool m_isInit;
};

#endif


