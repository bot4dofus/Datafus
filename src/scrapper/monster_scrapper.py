#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
from scrapper.item_scrapper import ItemScrapper


class MonsterScrapper(ItemScrapper):

    ###########
    # BUILDER #
    ###########

    def __init__(self, url, language):
        super().__init__(url, language)

    ################
    # NON OPTIONAL #
    ################

    def get_resistances(self):
        block = self.get_block('resistances')
        return self.get_array(block)

    ############
    # OPTIONAL #
    ############

    def get_level(self):
        level = super().get_level()
        levels = re.findall("\d+", level)
        if(len(levels) > 1):
            return (int(levels[0]), int(levels[1]))
        else:
            return (int(level), int(level))

    #########
    # SCRAP #
    #########

    def scrap(self):
        data = super().scrap()
        data['level'] = self.get_level()
        data['characteristics'] = self.get_characteristics()
        data['resistances'] = self.get_resistances()
        return data
