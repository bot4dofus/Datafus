#!/usr/bin/env python
# -*- coding: utf-8 -*-

from scrapper.item_scrapper import ItemScrapper


class SetScrapper(ItemScrapper):

    ###########
    # BUILDER #
    ###########

    def __init__(self, url, language):
        super().__init__(url, language)

    ################
    # NON OPTIONAL #
    ################

    def get_set_bonuses(self):
        block = self.get_block('set_bonuses')
        return self.get_array(block)

    def get_items(self):
        urls = []
        block = self.soup.findAll("div", {"class": "ak-item-list-preview"})[0]
        links = block.findChildren("a", recursive=False)
        for link in links:
            urls.append(self.DOMAIN + link['href'])
        return urls

    ############
    # OPTIONAL #
    ############

    def get_set_total_bonuses(self):
        block = self.get_block('set_total_bonuses')
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
        data['set_bonuses'] = self.get_set_bonuses()
        data['items'] = self.get_items()

        set_total_bonuses = self.get_set_total_bonuses()
        if(set_total_bonuses):
            data['set_total_bonuses'] = set_total_bonuses

        return data
