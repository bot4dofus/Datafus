#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.monster_scrapper import MonsterScrapper

class MonsterBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/monstres',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/monsters',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 1832, 'monsters', MonsterScrapper)
