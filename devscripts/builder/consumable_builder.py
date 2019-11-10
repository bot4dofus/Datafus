#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.consumable_scrapper import ConsumableScrapper

class ConsumableBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/consommables',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/consumables',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
		}

	def __init__(self, language):
		super().__init__(self.URL[language], 1415, 'consumables', ConsumableScrapper)

	@property
	def nb(self):
		return self._nb-1 # "https://www.dofus.com/fr/mmorpg/encyclopedie/consommables/19296-"" is always missing
