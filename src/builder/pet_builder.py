#!/usr/bin/env python
# -*- coding: utf-8 -*-

from builder.base_builder import BaseBuilder
from scrapper.pet_scrapper import PetScrapper


class PetBuilder(BaseBuilder):

    URL = {
        'fr': 'https://www.dofus.com/fr/mmorpg/encyclopedie/familiers',
        'en': 'https://www.dofus.com/en/mmorpg/encyclopedia/pets',
        'de': 'https://www.dofus.com/de/mmorpg/leitfaden/vertraute',
        'es': 'https://www.dofus.com/es/mmorpg/enciclopedia/mascotas',
        'it': 'https://www.dofus.com/it/mmorpg/enciclopedia/famigli',
        'pt': 'https://www.dofus.com/pt/mmorpg/enciclopedia/mascotes'
    }

    def __init__(self, language):
        super().__init__(self.URL[language], 'pets', PetScrapper, language,
                         ['url', 'id', 'name', 'img', 'type', 'level', 'description'])
