#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper


class MountScrapper(ItemScrapper):

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
        data['characteristics'] = self.get_characteristics()

        effects = self.get_effects()
        if(effects):
            data['effects'] = effects

        return data
