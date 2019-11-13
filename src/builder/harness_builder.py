#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.harness_scrapper import HarnessScrapper

class HarnessBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/harnachements',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/harnesses',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/zaumzeug',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/arreos',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/bardature',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/arreios'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 63, 'harnesses', HarnessScrapper, language,
			['level', 'description'])
