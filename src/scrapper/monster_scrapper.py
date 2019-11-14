#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
from scrapper.item_scrapper import ItemScrapper

class MonsterScrapper(ItemScrapper):

	def __init__(self, url, language):
		super().__init__(url, language)

	def scrap(self):
		data = super().scrap("ak-encyclo-detail-right")
		matching = re.match(r'([0-9]*) .* ([0-9]*)', data['level'])
		if(matching):
			data['level'] = (int(matching.group(1)), int(matching.group(2)))
		else:
			data['level'] = (int(data['level']), int(data['level']))
		return data
