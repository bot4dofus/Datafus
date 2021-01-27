#!/usr/bin/env python
# -*- coding: utf-8 -*-

import utils
import traceback

FILE = 'warnings.log'


def log(message):
    print(message, flush=True)

def info(message):
    message = '[INFO][{}] {}'.format(utils.get_time(), message)
    log(message)

def warning(message):
    message = '[WARNING][{}] {}'.format(utils.get_time(), message)
    log(message)
    file = open(FILE, 'a')
    file.write(message + '\n')
    file.close()


def error(e):
    message = ''.join(traceback.format_exception(None, e, e.__traceback__))
    log(message)
    file = open(FILE, 'a')
    file.write(message + '\n')
    file.close()
