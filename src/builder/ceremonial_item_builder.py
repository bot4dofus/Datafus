#!/usr/bin/env python
# -*- coding: utf-8 -*-

from builder.base_builder import BaseBuilder
from scrapper.ceremonial_item_scrapper import CeremonialItemScrapper


class CeremonialItemBuilder(BaseBuilder):

    URL = {
        'fr': 'https://www.dofus.com/fr/mmorpg/encyclopedie/objets-d-apparat',
        'en': 'https://www.dofus.com/en/mmorpg/encyclopedia/ceremonial-item',
        'de': 'https://www.dofus.com/de/mmorpg/leitfaden/prunkgegenstande',
        'es': 'https://www.dofus.com/es/mmorpg/enciclopedia/objeto-de-apariencia',
        'it': 'https://www.dofus.com/it/mmorpg/enciclopedia/oggetti-di-gala',
        'pt': 'https://www.dofus.com/pt/mmorpg/enciclopedia/item-de-aparencia'
    }

    def __init__(self, language):
        super().__init__(self.URL[language], 'ceremonial_items', CeremonialItemScrapper, language,
                         ['url', 'id', 'name', 'img', 'type', 'level', 'description'])
