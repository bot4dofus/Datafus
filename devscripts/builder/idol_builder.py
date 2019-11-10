#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.idol_scrapper import IdolScrapper

class IdolBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/idoles',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/idols',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 89, 'idols', IdolScrapper)
