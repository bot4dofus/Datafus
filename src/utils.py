#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json, logger, os

def read_json(file_name):
	if(not os.path.isfile(file_name)):
		raise Exception('File ' + file_name + ' does not exist. Build it first.')

	logger.log("Reading data from " + file_name)
	file = open(file_name,'r')
	data = json.loads(file.read())
	file.close()
	return data

def save_json(file_name, data):
	logger.log("Saving data to " + file_name)
	file = open(file_name,'w')
	file.write(json.dumps(data))
	file.close()

def contains_double(array):
	copy = []
	doubles = []
	for item in array:
		if item in copy:
			doubles.append(item)
		copy.append(item)
	return doubles
