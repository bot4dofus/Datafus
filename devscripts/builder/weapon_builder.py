#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.weapon_scrapper import WeaponScrapper

class WeaponBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/armes',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/weapons',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 726, 'weapons', WeaponScrapper)
