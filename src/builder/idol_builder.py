#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.idol_scrapper import IdolScrapper

class IdolBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/idoles',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/idols',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/idole',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/idolos',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/idoli',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/idolos'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 89, 'idols', IdolScrapper, language,
			['url', 'id', 'name', 'img', 'type', 'level', 'description', 'bonuses', 'spells', 'craft'])
