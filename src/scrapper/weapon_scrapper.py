#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class WeaponScrapper(ItemScrapper):

	def __init__(self, url, language):
		super().__init__(url, language)

	def scrap(self):
		data = super().scrap("ak-encyclo-detail-right")
		data['level'] = int(data['level'])
		return data
