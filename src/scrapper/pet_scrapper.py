#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper


class PetScrapper(ItemScrapper):

    ###########
    # BUILDER #
    ###########

    def __init__(self, url, language):
        super().__init__(url, language)

    ############
    # OPTIONAL #
    ############

    def get_evolutionary_effects(self):
        block = self.get_block('evolutionary_effects')
        if(block):
            return self.get_array(block)
        else:
            return None

    #########
    # SCRAP #
    #########

    def scrap(self):
        data = super().scrap()
        data['level'] = int(self.get_level())
        data['description'] = self.get_description()

        conditions = self.get_conditions()
        if(conditions):
            data['conditions'] = conditions

        evolutionary_effects = self.get_evolutionary_effects()
        if(evolutionary_effects):
            data['evolutionary_effects'] = evolutionary_effects

        return data
