#!/bin/env python
# -*- coding: utf-8 -*-

import os
import yaml
#读取具体的配置
def read_config_detail(filename):
	try:
		info = yaml.load(open(filename))
	except IOError, error:
		print(error)
	finally:
		return info

#读取配置模板
def read_config_tmpl(filename):
	rv = {} 
	order = []
	try:
		f = open(filename, "r")
		for line in f.readlines():
			line = line.strip()
			idx = line.find("--")
			if idx >= 0:
				line = line[0:idx]
			if line.find("=") > 0:
				kv = line.split("=")
				rv[kv[0].strip()] = kv[1].strip()
				order.append(kv[0].strip())
	except IOError, e:
		print(e)
	finally:
		if f:
			f.close()
		return rv, order

def gen_config(tmpl, detail, order):
	if not tmpl or not detail:
		print('gen_config error, tmpl or detail is None')
	try:
		for dk,dv in detail.items():
			outfile = dk
			print('writing file:' + dk)
			o = open(outfile, "w")
			for i in range(len(order)):
				tk = order[i]
				tv = tmpl[tk]
				hasK = dv.get(tk, None)
				if not hasK:
					line = tk + " = " + str(tv) + "\n"
					o.write(line)
				else:
					line = tk + " = " + str(dv[tk]) + "\n"
					o.write(line)
			'''
			for tk, tv in tmpl.items():
				hasK = dv.get(tk, None)
				if not hasK:
					line = tk + " = " + str(tv) + "\n"
					o.write(line)
				else:
					line = tk + " = " + str(dv[tk]) + "\n"
					o.write(line)
			'''
			o.close()

	except IOError, e:
		print(e)

detail = read_config_detail("./info.yaml")
'''
for K,V in detail.items():
	print(K)
	for k,v in V.items():
		print(k, v)
'''
tmpl,order = read_config_tmpl("./config.tmpl")
'''
if tmpl:
	for k, v in tmpl.items():
		print(k, v)
print(order)
'''
gen_config(tmpl, detail, order)
