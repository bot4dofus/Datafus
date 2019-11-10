#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class MountScrapper(ItemScrapper):

	def __init__(self, url):
		super().__init__(url)

	def scrap(self):
		data = super().scrap("ak-item-details-container")
		del data['level']
		return data
