#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.resource_scrapper import ResourceScrapper

class ResourceBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/ressources',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/resources',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/ressourcen',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/recursos',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/risorse',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/recursos'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 'resources', ResourceScrapper, language,
			['url', 'id', 'name', 'img', 'type', 'level', 'description'])