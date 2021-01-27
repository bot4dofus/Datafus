#!/usr/bin/env python
# -*- coding: utf-8 -*-

from builder.base_builder import BaseBuilder
from scrapper.monster_scrapper import MonsterScrapper


class MonsterBuilder(BaseBuilder):

    URL = {
        'fr': 'https://www.dofus.com/fr/mmorpg/encyclopedie/monstres',
        'en': 'https://www.dofus.com/en/mmorpg/encyclopedia/monsters',
        'de': 'https://www.dofus.com/de/mmorpg/leitfaden/monster',
        'es': 'https://www.dofus.com/es/mmorpg/enciclopedia/monstruos',
        'it': 'https://www.dofus.com/it/mmorpg/enciclopedia/mostri',
        'pt': 'https://www.dofus.com/pt/mmorpg/enciclopedia/monstros'
    }

    def __init__(self, language):
        super().__init__(self.URL[language], 'monsters', MonsterScrapper, language,
                         ['url', 'id', 'name', 'img', 'type', 'level', 'characteristics', 'resistances'])
