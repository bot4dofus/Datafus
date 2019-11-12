#!/usr/bin/env python
# -*- coding: utf-8 -*-

import utils

FILE = 'warnings.log'

def log(message):
	print(message)

def warning(message):
	message = '[' + utils.get_time() + '] ' + message
	log(message)
	file = open(FILE, 'a')
	file.write(message + '\n')
	file.close()
	