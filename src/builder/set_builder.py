#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.set_scrapper import SetScrapper

class SetBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/panoplies',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/sets',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/sets',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/sets',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/panoplie',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/conjuntos'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 331, 'sets', SetScrapper, language)