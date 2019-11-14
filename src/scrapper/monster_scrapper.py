#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
from scrapper.item_scrapper import ItemScrapper

class MonsterScrapper(ItemScrapper):

	###########
	# BUILDER #
	###########

	def __init__(self, url, language):
		super().__init__(url, language)

	################
	# NON OPTIONAL #
	################

	def get_resistances(self):
		block = self.get_block('resistances')
		return self.get_array(block)

	############
	# OPTIONAL #
	############

	def get_level(self):
		level = super().get_level()
		matching = re.match(r'([0-9]*) .* ([0-9]*)', level)
		if(matching):
			return (int(matching.group(1)), int(matching.group(2)))
		else:
			return (int(level), int(level))

	#########
	# SCRAP #
	#########

	def scrap(self):
		data = super().scrap()
		data['level'] = self.get_level()
		data['characteristics'] = self.get_characteristics()
		data['resistances'] = self.get_resistances()
		return data
