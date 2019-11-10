#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.equipment_scrapper import EquipmentScrapper

class EquipmentBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/equipements',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/equipment',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 2329, 'equipments', EquipmentScrapper)
