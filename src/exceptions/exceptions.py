#!/usr/bin/env python
# -*- coding: utf-8 -*-

class DatafusException(Exception):
    
    def __init__(self, message):
    	super().__init__(message)
        