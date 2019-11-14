#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json, logger
from scrapper.list_scrapper import ListScrapper
from exceptions.exceptions import PageNotFoundException

class BaseBuilder():

	def __init__(self, url, nb, field_name, scrapper, language, mandatory_fields):
		super().__init__()
		self._url = url
		self._nb = nb
		self._field_name = field_name
		self._scrapper = scrapper
		self._language = language
		self._mandatory_fields = mandatory_fields

	@property
	def url(self):
		return self._url

	@property
	def nb(self):
		return self._nb

	@property
	def field_name(self):
		return self._field_name

	@property
	def scrapper(self):
		return self._scrapper

	@property
	def language(self):
		return self._language

	@property
	def mandatory_fields(self):
		return self._mandatory_fields

	def match(self, url):
		return self.url in url

	def build(self):
		logger.log('Building ' + self._field_name + ' :')

		data = []

		ls = ListScrapper(self._url, self._nb)
		urls = ls.scrap()

		for i in range(len(urls)):
			logger.log('Scrapping item ' + str(i+1) + '/' + str(len(urls)))
			try:
				scrapper = self._scrapper(urls[i], self._language)
				try:
					data.append(scrapper.scrap())
				except Exception:
					logger.warning("Skipping " +  urls[i] + ", missing mandatory field")
			except PageNotFoundException:
				logger.warning("Skipping " + urls[i] + ", page does not exist")

		return data
