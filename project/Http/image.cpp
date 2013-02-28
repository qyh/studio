#include "image.h"

bool Image::tgaToJpg(const char *tga, const char *jpg)
{
	unsigned char jpgHeader[4] = {255,216,255,254};
	Chars tgafile, jpgfile;
	int tga_h_l = 18;
	if (!tgafile.readFile(tga)){
		return false;
	}
	tgafile.print(0,10);
	jpgfile.assign((char*)jpgHeader, 4);
	jpgfile.append(tgafile.substr(tga_h_l, tgafile.length() - tga_h_l).c_str(), 
		tgafile.length() - tga_h_l);
	if (!jpgfile.writeFile(jpg)) {
		return false;
	}
	jpgfile.print(0,10);
	return true;
}
