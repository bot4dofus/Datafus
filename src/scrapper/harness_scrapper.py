#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class HarnessScrapper(ItemScrapper):

	###########
	# BUILDER #
	###########

	def __init__(self, url, language):
		super().__init__(url, language)

	#########
	# SCRAP #
	#########

	def scrap(self):
		data = super().scrap()
		data['level'] = int(self.get_level())
		data['description'] = self.get_description()

		conditions = self.get_conditions()
		if(conditions):
			data['conditions'] = conditions

		craft = self.get_craft()
		if(craft):
			data['craft'] = craft
		
		return data
