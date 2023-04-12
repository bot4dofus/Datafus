import struct
import json
import sys
import os


def save_file(file_name, data):
    with open(file_name, 'w', encoding='utf8') as f:
        json.dump(data, f, indent='\t', ensure_ascii=False)


class DofusFileReader():

    INT_SIZE = 4
    SHORT_SIZE = 2
    BOOL_SIZE = 1

    def __init__(self, file, file_format):
        self.file = file
        self.file_format = file_format

    def readBytes(self, f, size):
        return f.read(size)

    def skip(self, f, length):
        return f.seek(f.tell() + length)

    def readInt(self, f):
        r = struct.unpack('>i', self.readBytes(f, self.INT_SIZE))
        return r[0]

    def skipInt(self, f):
        self.skip(f, self.INT_SIZE)

    def readShort(self, f):
        r = struct.unpack('>h', self.readBytes(f, self.SHORT_SIZE))
        return r[0]

    def skipShort(self, f):
        self.skip(f, self.SHORT_SIZE)

    def readBool(self, f):
        r = struct.unpack('>?', self.readBytes(f, self.BOOL_SIZE))
        return r[0]

    def skipBool(self, f):
        self.skip(f, self.BOOL_SIZE)

    def readUtf(self, f):
        stringLength = self.readShort(f)
        # Security mesure for the utf in location 4139591 which has a negative length... this is an error from dofus devs
        if(stringLength > 0):
            return self.readBytes(f, stringLength).decode()
        return ""

    def readString(self, f, location):
        previousLocation = f.tell()
        f.seek(location)
        string = self.readUtf(f)
        f.seek(previousLocation)
        return string


class D2IReader(DofusFileReader):

    FORMAT = b'D2I'

    def __init__(self, file):
        super().__init__(file, self.FORMAT)

    def read_all(self):
        data = {}

        with open(self.file, "rb") as f:

            # Index location
            indexLocation = self.readInt(f)
            f.seek(indexLocation)

            # IndexTable
            indexSize = self.readInt(f)
            endIndexLocation = f.tell() + indexSize

            while f.tell() < endIndexLocation:
                id = self.readInt(f)
                diacriticExists = self.readBool(f)
                data[str(id)] = self.readString(f, self.readInt(f))

                if(diacriticExists):
                    # Skip the string
                    self.skipInt(f)

        return data

    def read(self, id_to_search):
        result = None

        with open(self.file, "rb") as f:

            # Index location
            indexLocation = self.readInt(f)
            f.seek(indexLocation)

            # IndexTable
            indexSize = self.readInt(f)
            endIndexLocation = f.tell() + indexSize

            while f.tell() < endIndexLocation:
                id = self.readInt(f)
                diacriticExists = self.readBool(f)

                if(id_to_search <= id):
                    if(id_to_search == id):
                        result = self.readString(f, self.readInt(f))
                    break

                # Skip the string
                self.skipInt(f)

                if(diacriticExists):
                    # Skip the string
                    self.skipInt(f)

        return result.encode().decode('unicode-escape')


def main(input, output, are_files):
    files_to_convert = {}

    if (are_files):
        files_to_convert[input] = output
    else:
        files_in_input = os.listdir(input)
        for file_in_input in files_in_input:
            files_to_convert[input + file_in_input] = output + file_in_input.split('.')[0] + '.json'

    for key in files_to_convert:
        try:
            print("Extracting " + str(key), flush=True)
            reader = D2IReader(key)
            data = reader.read_all()
            print("Building " + str(files_to_convert[key]), flush=True)
            save_file(files_to_convert[key], data)
        except Exception as e:
            print(str(e))


if __name__ == "__main__":
    if(len(sys.argv) != 3):
        raise Exception("Needs two arguments of same type: Two files or two folders")

    if(not os.path.exists(sys.argv[1])):
        raise Exception("The input {} does not exists".format(sys.argv[1]))

    if(not os.path.exists(sys.argv[2])):
        raise Exception("The output {} does not exists".format(sys.argv[2]))

    are_files = (os.path.isfile(sys.argv[1]) and os.path.isfile(sys.argv[2]))    # If input and output are files
    are_folders = (os.path.isdir(sys.argv[1]) and os.path.isdir(sys.argv[2]))    # If input and output are folders

    if(not(are_files or are_folders)):
        raise Exception("Needs two arguments of same type: Two files or two folders")

    main(sys.argv[1], sys.argv[2], are_files)
