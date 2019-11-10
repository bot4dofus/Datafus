#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.sidekick_scrapper import SidekickScrapper

class SidekickBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/compagnons',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/sidekicks',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 12, 'sidekicks', SidekickScrapper)
