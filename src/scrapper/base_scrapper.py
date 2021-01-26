#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
import logger
import re
import cloudscraper
from bs4 import BeautifulSoup
from exceptions.exceptions import DatafusException

CLOUDSCRAPPER = cloudscraper.CloudScraper()


class BaseScrapper():

    DOMAIN = 'https://www.dofus.com'
    STATIC_DOMAIN = 'http://staticns.ankama.com'
    WAIT_ON_429 = 70
    MAX_ITERATIONS = 5

    ###########
    # BUILDER #
    ###########

    def __init__(self, url):
        self.url = url

    ##########
    # STATIC #
    ##########

    def get_id_from_url(self, url):
        trailer = url[url.rfind('/')+1:]
        return int(trailer[:trailer.find('-')])

    def get_language_from_url(self, url):
        matching = re.match(r'https://www.dofus.com/(.*)/mmorpg/.*', url)
        if(matching):
            return matching.group(1)
        else:
            raise DatafusException('Not a valid url')

    ###########
    # GENERAL #
    ###########

    def requests(self, url, iteration=0):
        if(iteration >= self.MAX_ITERATIONS):
            raise DatafusException('Maximum iterations reached ({})'.format(self.MAX_ITERATIONS))

        page = CLOUDSCRAPPER.get(url)

        if(page.status_code == 429):
            logger.log("Waiting {} seconds".format(self.WAIT_ON_429))
            time.sleep(self.WAIT_ON_429)
            return self.requests(url, iteration=iteration+1)

        elif(page.status_code == 404):
            raise DatafusException('Error code {} for url {}'.format(page.status_code, url))

        elif(page.status_code != 200):
            raise DatafusException('Error code {} for url {}'.format(page.status_code, url))

        return BeautifulSoup(page.text, 'html.parser')
