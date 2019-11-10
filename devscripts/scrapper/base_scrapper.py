#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests, time, logger
from bs4 import BeautifulSoup
from exceptions.exceptions import PageNotFoundException

class BaseScrapper():
	
	DOMAIN = 'https://www.dofus.com'
	STATIC_DOMAIN = 'http://staticns.ankama.com'
	WAIT_ON_429 = 70
	MAX_ITERATIONS = 5

	def __init__(self):
		pass

	def requests(self, url, iteration=0):
		if(iteration >= self.MAX_ITERATIONS):
			raise Exception('Maximum iterations reached (' + str(self.MAX_ITERATIONS) + ')')

		page = requests.get(url)

		if(page.status_code == 429):
			logger.log("Waiting " + str(self.WAIT_ON_429))
			time.sleep(self.WAIT_ON_429)
			return self.requests(url, iteration=iteration+1)

		elif(page.status_code == 404):
			raise PageNotFoundException('Error code ' + str(page.status_code) + " for url " + url)

		elif(page.status_code != 200):
			raise Exception('Error code ' + str(page.status_code) + " for url " + url)

		return BeautifulSoup(page.text, 'html.parser') 
