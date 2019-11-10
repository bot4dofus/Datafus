#!/usr/bin/env python
# -*- coding: utf-8 -*-

class PageNotFoundException(Exception):
    
    def __init__(self, message):
    	super().__init__(message)
        