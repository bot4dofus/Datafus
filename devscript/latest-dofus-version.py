from urllib.request import Request, urlopen
import xml.etree.ElementTree as ET


class DofusVersionReader:

    RSS_FLUX = "https://www.dofus.com/fr/rss/changelog.xml"
    HEADERS = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
    }
    SUCCESS_CODE = 200

    def is_version(self, version):
        try:
            int(version.replace('.', ''))
            return True
        except ValueError:
            return False

    def get_version(self):

        req = Request(self.RSS_FLUX, None, self.HEADERS)
        changelog = urlopen(req)

        if (changelog.getcode() != self.SUCCESS_CODE):
            raise Exception("HTTP request failed")

        root = ET.fromstring(changelog.read())
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
    reader = DofusVersionReader()
    print(reader.get_version())


if __name__ == "__main__":
    main()
