#!/usr/bin/python
#coding=utf8
import codecs
import sys

inputFile = sys.argv[1]
outputFile = inputFile + "_out"
f = codecs.open(inputFile, 'r', 'gb18030');
s = f.read();
f.close()
#s.decode('gbk', 'ignore').encode('utf8');
out = codecs.open(inputFile, 'w', 'utf8');
out.write(s)


out.close()

