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

	// @brief tga 格式图片到jpg格式的转换: 输入tga文件，转换后的文件输出到
	// jpg指定的文件中
	// @param tga tga文件名, jpg jpg文件名
	// @return true 转换成功, false 转换失败
	static bool tgaToJpg(const char *tga, const char *jpg);
private:

	Chars m_data;
};

#endif

