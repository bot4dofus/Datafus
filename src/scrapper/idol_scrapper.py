#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper

class IdolScrapper(ItemScrapper):

	###########
	# BUILDER #
	###########

	def __init__(self, url, language):
		super().__init__(url, language)

	################
	# NON OPTIONAL #
	################

	def get_bonuses(self):
		block = self.get_block('bonuses')
		return self.get_array(block)

	def get_spells(self):
		block = self.get_block('spells')
		return self.get_text(block)

	#########
	# SCRAP #
	#########

	def scrap(self):
		data = super().scrap()
		data['level'] = int(self.get_level())
		data['description'] = self.get_description()
		data['bonuses'] = self.get_bonuses()
		data['spells'] = self.get_spells()
		data['craft'] = self.get_craft()
		return data
