#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
import logger
from scrapper.base_scrapper import BaseScrapper


class ListScrapper(BaseScrapper):

    SIZE = 96

    ###########
    # BUILDER #
    ###########

    def __init__(self, url):
        super().__init__(url)

    #########
    # SCRAP #
    #########

    def find_urls(self, soup):
        urls = []
        items = soup.findAll("tr", {"class": "ak-bg-odd"}) + soup.findAll("tr", {"class": "ak-bg-even"})
        for item in items:
            url = self.DOMAIN + item.find_all("td", recursive=False)[1].find_all("a")[0]['href']
            if(self.is_url_valid(url)):
                urls.append(url)
            else:
                logger.warning('Skipping {} : The url is not valid'.format(url))
        return urls

    def find_nb_pages(self, soup):
        div = soup.find("div", {"class": "ak-list-info"})
        if(div != None):
            nb = int(div.find('strong').text)
            return math.ceil(nb/self.SIZE)
        else:
            return 1

    def scrap(self):

        urls = []

        logger.info('Scrapping page 1/?')
        soup = self.requests(self.url + "?size={}".format(self.SIZE))
        nb_page = self.find_nb_pages(soup)
        urls.extend(self.find_urls(soup))

        for i in range(2, nb_page+1):
            logger.info('Scrapping page {}/{}'.format(i, nb_page))
            soup = self.requests(self.url + "?size={}&page={}".format(self.SIZE, i))
            urls.extend(self.find_urls(soup))

        return urls
