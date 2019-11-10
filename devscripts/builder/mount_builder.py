#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.mount_scrapper import MountScrapper

class MountBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/montures',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/mounts',
		'de' : 'https://www.dofus.com/de/mmorpg/leitfaden/reittiere',
		'es' : 'https://www.dofus.com/es/mmorpg/enciclopedia/monturas',
		'it' : 'https://www.dofus.com/it/mmorpg/enciclopedia/cavalcature',
		'pt' : 'https://www.dofus.com/pt/mmorpg/enciclopedia/montarias'
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 142, 'mounts', MountScrapper, language)
