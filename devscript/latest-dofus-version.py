import requests
import xml.etree.ElementTree as ET

RSS_FLUX = "https://www.dofus.com/fr/rss/changelog.xml"


class DofusVersionReader:

    def __init__(self, url):
        self.url = url

    def is_version(self, version):
        try:
            int(version.replace('.', ''))
            return True
        except ValueError:
            return False

    def get_version(self):

        changelog = requests.get(self.url)

        if (changelog.status_code != 200):
            raise Exception("HTTP request failed")

        root = ET.fromstring(changelog.text)
        versions = []

        for item in root.findall("./channel/item"):
            version = item.find("title").text.split(' ')[-1]
            versions.append(version)

            if(len(versions) == 2):
                break

        if (not self.is_version(versions[0])):
            first_point_index = versions[1].find('.')
            second_point_index = versions[1].find('.', 2)
            first_value = versions[1][:first_point_index+1]
            second_value = int(versions[1][first_point_index+1:second_point_index])
            versions[0] = first_value + str(second_value+1)

        return versions[0]


def main():
    reader = DofusVersionReader(RSS_FLUX)
    print(reader.get_version())


if __name__ == "__main__":
    main()
