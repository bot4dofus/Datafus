import struct
import json
import sys
import os

VERBOSE = 0

def log(log):
    if(VERBOSE > 0):
        print(log)

def save_file(file_name, data):
    file = open(file_name, 'w')
    file.write(json.dumps(data, indent='\t'))
    file.close()

class D2IReader():

    FORMAT = b'D2I'
    
    def __init__(self, file):
        self.file = file
        self.offset = 0
        self.classes = {}
        with open(file, "rb") as f:
            self.data = f.read()
            log(self.data)

    def readBytes(self, size):
        r = self.data[self.offset: self.offset+size]
        self.offset += size
        log(r)
        return r

    def seek(self, offset):
        self.offset = offset

    def readInt(self):
        r = struct.unpack('>i', self.readBytes(4))
        return r[0]

    def readShort(self):
        r = struct.unpack('>h', self.readBytes(2))
        return r[0]

    def readBool(self):
        r = struct.unpack('>?', self.readBytes(1))
        return r[0]
        
    def readUtf(self):
        return self.readBytes(self.readShort()).decode()

    def readString(self, location):
        previousLocation = self.offset
        self.seek(location)
        string = self.readUtf()
        self.offset = previousLocation
        return string
  
    def read(self):
        data = {}

        # Index location
        indexLocation = self.readInt()
        self.seek(indexLocation)

        # IndexTable
        indexSize = self.readInt()
        endIndexLocation = self.offset + indexSize
        
        while self.offset < endIndexLocation:

            id = self.readInt()
            diacriticExists = self.readBool()

            data[str(id)] = [
                self.readString(self.readInt())
            ]
            
            if(diacriticExists):
                data[str(id)].append(self.readString(self.readInt()))

        return data

def main(input, output, is_files):
    files_to_convert = {}
    
    if (is_files):
        files_to_convert[input] = output;
    else:
        files_in_input = os.listdir(input)
        for file_in_input in files_in_input:
            files_to_convert[input + file_in_input] = output + file_in_input.split('.')[0] + '.json'

    for key in files_to_convert:
        try:
            print("Extracting " + str(key), flush=True)
            reader = D2IReader(key)
            data = reader.read()
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

    are_files = (os.path.isfile(sys.argv[1]) and os.path.isfile(sys.argv[2]))    #If input and output are files
    are_folders = (os.path.isdir(sys.argv[1]) and os.path.isdir(sys.argv[2]))    #If input and output are folders 

    if(not(are_files or are_folders)):
        raise Exception("Needs two arguments of same type: Two files or two folders")

    main(sys.argv[1], sys.argv[2], are_files)
