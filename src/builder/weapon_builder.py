#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.weapon_scrapper import WeaponScrapper

class WeaponBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/armes',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/weapons',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/waffen',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/armas',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/armi',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/armas'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 'weapons', WeaponScrapper, language,
			['url', 'id', 'name', 'img', 'type', 'level', 'description', 'characteristics'])
