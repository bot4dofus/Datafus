#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.harness_scrapper import HarnessScrapper

class HarnessBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/harnachements',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/harnesses',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 63, 'harnesses', HarnessScrapper)
