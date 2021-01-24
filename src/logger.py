#!/usr/bin/env python
# -*- coding: utf-8 -*-

import utils

FILE = 'warnings.log'

def log(message):
	print(message, flush=True)

def warning(message):
	message = '[WARNING][' + utils.get_time() + '] ' + message
	log(message)
	file = open(FILE, 'a')
	file.write(message + '\n')
	file.close()

def error(e):
	message = '[ERROR][' + utils.get_time() + '] ' + str(e)
	log(message)
	file = open(FILE, 'a')
	file.write(message + '\n')
	file.close()
    