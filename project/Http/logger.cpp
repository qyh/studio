#include "logger.h"
#include "utility.h"

std::string		Logger::m_text;		// ��־����
fast_mutex		Logger::m_text_lock; // ������
std::ofstream	Logger::m_logfile; // ��־�ļ�
size_t			Logger::m_buffer_size; // ��������С
bool			Logger::m_isInit = false;

// @brief ��ʼ����־��Ϣ,����־�ļ�
// @param logfile ָ����־�ļ���, bufsize ��־��������С
// @return �ɹ�����true, ʧ�ܷ���false
bool Logger::Initialize(const char *logfile, size_t bufsize)
{
	if (m_isInit) {
		return true;
	}
	m_buffer_size = bufsize;
	m_logfile.open(logfile, ios_base::out | ios_base::app);
	if (!m_logfile.is_open()) {
		// Open log file faild
		return false;
	}
	m_isInit = true;
	return true;
}

// @brief ����־��Ϣд�뵽������
// @param ident �ӵ�ÿ����־ǰ����Ϣ(һ��Ϊ������), 
// level ��־����, fmt ��ʽ���ַ���
// @return �ɹ�����true, ʧ�ܷ��� false 
bool Logger::Write(const char *ident, LOG_LEVEL level, const char* fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	char *pBuf = NULL;

	if (!m_isInit) {
		return false;
	}
	m_text_lock.lock();
	std::string line = "[";
	line += Utility::currentDateTime() + "] ";
	line += ident;
	switch (level)
	{
	case LOG_DEBUG:
		line += " DEBUG: ";
		break;
	case LOG_ERR:
		line += " ERROR: ";
		break;
	case LOG_INFO:
		line += " INFO: ";
		break;
	case LOG_NOTICE:
		line += " NOTICE: ";
		break;
	case LOG_WARNING:
		line += " WARNING: ";
		break;
	}


#ifdef _WIN32
	int bufsize = _vscprintf(fmt, ap) + 1;
	pBuf = (char *)calloc(1, bufsize);
	vsprintf_s(pBuf, bufsize, fmt, ap);
#else
	int bufsize = vasprintf(&pBuf, fmt, ap) + 1;
	vsnprintf(pBuf, bufsize, fmt, ap);
#endif 
	va_end(ap);
	
	line += pBuf;
	line += "\n";
	m_text += line;
	m_text_lock.unlock();

	if (m_text.length() > m_buffer_size) {
		Flush();
	}
	free(pBuf);

	return true;
}

// @brief ������������д�뵽�ļ����������־������
// @param void
// @return void
void Logger::Flush(void)
{
	if (!m_isInit) {
		return;
	}
	m_text_lock.lock();
	m_logfile.write(m_text.c_str(), m_text.length());
	if (m_logfile.fail()) {
		m_text_lock.unlock();
		return;
	}
	m_text = "";
	m_text_lock.unlock();
}

// @brief ���δд������ݣ��رմ򿪵��ļ�
void Logger::Uninit(void)
{	
	if (!m_text.empty()) {
		Flush();
	}
	m_logfile.close();
}

