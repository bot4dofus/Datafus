#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.equipment_scrapper import EquipmentScrapper

class EquipmentBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/equipements',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/equipment',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/ausruestung',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/equipos',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/equipaggiamenti',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/equipamentos'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 2329, 'equipments', EquipmentScrapper, language)
