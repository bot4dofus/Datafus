#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.ceremonial_item_scrapper import CeremonialItemScrapper

class CeremonialItemBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/objets-d-apparat',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/ceremonial-item',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 711, 'ceremonial_items', CeremonialItemScrapper)
