#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper


class SidekickScrapper(ItemScrapper):

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
        data['description'] = self.get_description()
        data['characteristics'] = self.get_characteristics()
        return data
