#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math, logger
from scrapper.base_scrapper import BaseScrapper

class ListScrapper(BaseScrapper):

	SIZE = 96

	def __init__(self, url, nb):
		super().__init__()
		self.url = url
		self.nb = nb

	def scrap(self):

		urls = []
		nb_page = math.ceil(self.nb/self.SIZE)

		for i in range(1, nb_page+1):
			logger.log('Scrapping page ' + str(i) + '/' + str(nb_page))

			soup = self.requests(self.url + "?size=" + str(self.SIZE) + "&page=" + str(i))
			items = soup.findAll("tr", {"class": "ak-bg-odd"}) + soup.findAll("tr", {"class": "ak-bg-even"})
			
			for item in items:
				urls.append(self.DOMAIN + item.find_all("td" , recursive=False)[1].find_all("a")[0]['href'])

		if len(urls) != self.nb:
			raise Exception('Expected ' + str(self.nb) + ' items, got ' + str(len(urls)))

		return urls
