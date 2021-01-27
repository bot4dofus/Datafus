#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper


class CeremonialItemScrapper(ItemScrapper):

    ###########
    # BUILDER #
    ###########

    def __init__(self, url, language):
        super().__init__(url, language)

    #########
    # SCRAP #
    #########

    def scrap(self):
        data = super().scrap()
        data['level'] = int(self.get_level())
        data['description'] = self.get_description()

        effects = self.get_effects()
        if(effects):
            data['effects'] = effects

        conditions = self.get_conditions()
        if(conditions):
            data['conditions'] = conditions

        characteristics = self.get_characteristics()
        if(characteristics):
            data['characteristics'] = characteristics

        craft = self.get_craft()
        if(craft):
            data['craft'] = craft

        return data
