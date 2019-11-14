#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class SetScrapper(ItemScrapper):

	def __init__(self, url, language):
		super().__init__(url, language)

	def get_urls(self):
		urls = []

		block = self.soup.findAll("div", {"class": "ak-item-list-preview"})[0]
		links = block.findChildren("a", recursive=False)

		for link in links:
			urls.append(self.DOMAIN + link['href'])

		return urls

	def scrap(self):
		data = super().scrap("ak-encyclo-detail-right")
		data['level'] = int(data['level'])
		data['items'] = self.get_urls()
		return data
