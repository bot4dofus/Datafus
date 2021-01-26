#!/usr/bin/env python
# -*- coding: utf-8 -*-

import logger
from builder.base_builder import BaseBuilder
from scrapper.consumable_scrapper import ConsumableScrapper


class ConsumableBuilder(BaseBuilder):

    URL = {
        'fr': 'https://www.dofus.com/fr/mmorpg/encyclopedie/consommables',
        'en': 'https://www.dofus.com/en/mmorpg/encyclopedia/consumables',
        'de': 'https://www.dofus.com/de/mmorpg/leitfaden/konsumgueter',
        'es': 'https://www.dofus.com/es/mmorpg/enciclopedia/consumibles',
        'it': 'https://www.dofus.com/it/mmorpg/enciclopedia/consumabili',
        'pt': 'https://www.dofus.com/pt/mmorpg/enciclopedia/itens-consumiveis'
    }

    def __init__(self, language):
        super().__init__(self.URL[language], 'consumables', ConsumableScrapper, language,
                         ['url', 'id', 'name', 'img', 'type', 'level', 'description'])
