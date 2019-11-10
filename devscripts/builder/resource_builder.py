#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.resource_scrapper import ResourceScrapper

class ResourceBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/ressources',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/resources',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 2780, 'resources', ResourceScrapper)