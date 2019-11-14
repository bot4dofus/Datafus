#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests, time, logger, re
from bs4 import BeautifulSoup
from exceptions.exceptions import PageNotFoundException

class BaseScrapper():
	
	DOMAIN = 'https://www.dofus.com'
	STATIC_DOMAIN = 'http://staticns.ankama.com'
	WAIT_ON_429 = 70
	MAX_ITERATIONS = 5

	###########
	# BUILDER #
	###########
	
	def __init__(self, url):
		self.url = url

	##########
	# STATIC #
	##########

	def get_id_from_url(self, url):
		trailer = url[url.rfind('/')+1:]
		return int(trailer[:trailer.find('-')])

	def get_language_from_url(self, url):
		matching = re.match(r'https://www.dofus.com/(.*)/mmorpg/.*', url)
		if(matching):
			return matching.group(1)
		else:
			raise Exception('Not a valid url')

	###########
	# GENERAL #
	###########

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
