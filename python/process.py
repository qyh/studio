#!/bin/env python 
# -*- coding: UTF-8 -*-
'''
读取奖励玩家信息 award_list.txt
读取已写记录玩家信息 record_success.txt
输出已发奖但没有写记录的玩家信息
'''
try:
	award_list_f = open("award_list.txt", "r")
	record_list_f = open("record_success.txt", "r")

	award_map = {}
	record_list = {} 
	print("award list:")
	for line in award_list_f.readlines():
		line = line.strip()
		kv = line.split()
		award_map[kv[0]] = kv[1]

	print("record list:")
	for line in record_list_f.readlines():
		line = line.strip()
		record_list[line] = True

	#print(award_map)
	i=0
	for k, v in award_map.items():
		rv = record_list.get(k, None)
		if not rv:  
			i = i + 1
			print(k,v)

	#print(record_list)
	print("award count:", len(award_map))
	print("un record count:", i)
except IOError, e :
	print('error occurs', e)
finally:
	if award_list_f:
		award_list_f.close()
	if record_list_f:
		record_list_f.close()


