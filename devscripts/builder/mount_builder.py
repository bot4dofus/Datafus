#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.mount_scrapper import MountScrapper

class MountBuilder(BaseBuilder):

	URL = {
		'fr' : 'https://www.dofus.com/fr/mmorpg/encyclopedie/montures',
		'en' : 'https://www.dofus.com/en/mmorpg/encyclopedia/mounts',
		# 'de' : ,
		# 'es' : ,
		# 'it' : ,
		# 'pt' : 
	}

	def __init__(self, language):
		super().__init__(self.URL[language], 142, 'mounts', MountScrapper)
