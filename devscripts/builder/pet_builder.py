#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.pet_scrapper import PetScrapper

class PetBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/familiers',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/pets',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 131, 'pets', PetScrapper)
