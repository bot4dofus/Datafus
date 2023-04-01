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

    def increment_version(self, version):
        first_point_index = version.find('.')
        second_point_index = version.find('.', 2)
        first_value = version[:first_point_index+1]
        second_value = int(version[first_point_index+1:second_point_index])
        new_version = first_value + str(second_value+1)
        return new_version

    def get_version(self):

        req = Request(self.RSS_FLUX, None, self.HEADERS)
        changelog = urlopen(req)

        if (changelog.getcode() != self.SUCCESS_CODE):
            raise Exception("HTTP request failed")

        root = ET.fromstring(changelog.read())
        items = root.findall("./channel/item")

        for i in range(len(items)):
            version = items[i].find("title").text.split(' ')[-1]

            if(self.is_version(version)):
                if(i != 0):
                    version = self.increment_version(version)
                return version

        raise Exception("No version found")


def main():
    reader = DofusVersionReader()
    print(reader.get_version())


if __name__ == "__main__":
    main()
