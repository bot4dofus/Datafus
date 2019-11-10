#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class SidekickScrapper(ItemScrapper):

	def __init__(self, url):
		super().__init__(url)

	def scrap(self):
		data = super().scrap("ak-encyclo-detail")
		del data['level']
		return data
