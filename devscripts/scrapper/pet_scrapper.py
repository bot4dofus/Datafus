#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class PetScrapper(ItemScrapper):

	def __init__(self, url):
		super().__init__(url)

	def scrap(self):
		return super().scrap("ak-encyclo-detail-right")
