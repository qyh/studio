#ifndef __IMAGE_H
#define __IMAGE_H

#include "chars.h"

class Image;

class Image
{
public:
	// @brief Constructor
	Image();

	// @brief Destructor
	~Image();

	// @brief tga ��ʽͼƬ��jpg��ʽ��ת��: ����tga�ļ���ת������ļ������
	// jpgָ�����ļ���
	// @param tga tga�ļ���, jpg jpg�ļ���
	// @return true ת���ɹ�, false ת��ʧ��
	static bool tgaToJpg(const char *tga, const char *jpg);
private:

	Chars m_data;
};

#endif

