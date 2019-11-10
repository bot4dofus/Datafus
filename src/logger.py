#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time

FILE = 'warnings.log'

def get_time():
	return time.strftime("%y-%M-%d_%X")

def log(message):
	print(message)

def warning(message):
	message = '[' + get_time() + '] ' + message
	log(message)
	file = open(FILE, 'a')
	file.write(message + '\n')
	file.close()
	