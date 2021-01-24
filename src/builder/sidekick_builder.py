#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.sidekick_scrapper import SidekickScrapper

class SidekickBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/compagnons',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/sidekicks',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/begleiter',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/companeros',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/compagni',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/companheiros'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 'sidekicks', SidekickScrapper, language,
			['url', 'id', 'name', 'img', 'type', 'description', 'characteristics'])
