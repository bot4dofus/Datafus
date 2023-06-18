
import os
import requests
import Cytrus.Manifest
import hashlib
from utils import to_hex_string, get_chunk_range, output_folder

def get_manifest(version):
    data = bytearray(get_manifest_file(version))
    return Cytrus.Manifest.Manifest.GetRootAsManifest(data)


def get_manifest_file(version):
    response = requests.get(f"https://cytrus.cdn.ankama.com/dofus/releases/main/windows/{version}.manifest")
    return response.content


def get_latest_version():
    response = requests.get("https://cytrus.cdn.ankama.com/cytrus.json")
    return response.json()['games']['dofus']['platforms']['windows']['main']


def get_needed_chunks(fragment, files):
    needed_chunks = []
    for j in range(fragment.FilesLength()):
        file = fragment.Files(j)
        name = file.Name().decode('utf-8')

        if len(files) == 0 or name in files:
            hash = to_hex_string(file.HashAsNumpy().tobytes())
            
            if file.ChunksLength() == 0:
                needed_chunks.append(hash)
            
            for k in range(file.ChunksLength()):
                file_chunk = file.Chunks(k)
                file_chunk_hash = to_hex_string(file_chunk.HashAsNumpy().tobytes())
                needed_chunks.append(file_chunk_hash)

    return needed_chunks


def download_chunks(fragment, needed_chunks):
    downloaded_data = {}
    for j in range(0, fragment.BundlesLength()):
        print(f"Downloading bundle {j + 1}/{fragment.BundlesLength()}")
        bundle = fragment.Bundles(j)
        chunk_ranges = []

        for k in range(0, bundle.ChunksLength()):
            chunk = bundle.Chunks(k)
            chunk_hash = to_hex_string(chunk.HashAsNumpy().tobytes())

            if chunk_hash in needed_chunks:
                chunk_ranges.append(get_chunk_range(chunk))
            
        if len(chunk_ranges) > 0:
            bundle_hash = to_hex_string(bundle.HashAsNumpy().tobytes())
            bundle_data = download_bundle(bundle_hash, ",".join(chunk_range[0] for chunk_range in chunk_ranges))
            downloaded_data = downloaded_data | split_cloudflare_response(bundle_data, chunk_ranges)
    return downloaded_data
        

def save_files(fragment, downloaded_data, files):
    for j in range(fragment.FilesLength()):
        file = fragment.Files(j)
        name = file.Name().decode('utf-8')
        
        if len(files) == 0 or name in files:
            hash = to_hex_string(file.HashAsNumpy().tobytes())
            chunks = []

            if file.ChunksLength() < 1:
                value = downloaded_data.get(hash, None)
                if value is not None:
                    chunks.append(value)

            for k in range(file.ChunksLength()):
                file_chunk = file.Chunks(k)
                file_chunk_hash = to_hex_string(file_chunk.HashAsNumpy().tobytes())
                value = downloaded_data.get(file_chunk_hash, None)
                if value is not None:
                    chunks.append(value)
        
            filepath = output_folder + name


            path = os.path.dirname(filepath)
            os.makedirs(path, exist_ok=True)


            print("Saving", name)
            with open(filepath, "wb") as fd:
                if(len(chunks)): 
                    fd.write(b"".join(chunks))


def parse_fragments(manifest, files = []):
    for i in range(0, manifest.FragmentsLength()):
        print(f"Parsing fragment {i + 1}/{manifest.FragmentsLength()}")
        fragment = manifest.Fragments(i)
        
        needed_chunks = get_needed_chunks(fragment, files)
        downloaded_data = download_chunks(fragment, needed_chunks)
        save_files(fragment, downloaded_data, files)
                

def download_bundle(bundle_hash, bundle_range):
    url = f"https://cytrus.cdn.ankama.com/dofus/bundles/{bundle_hash[0:2]}/{bundle_hash}"
    response = requests.get(url, headers={ "Range": f"bytes={bundle_range}"})
    return response.content


def split_cloudflare_response(response, chunk_ranges):
    data = {}
    if len(chunk_ranges) == 1:
        data[chunk_ranges[0][1]] = response
        return data

    index = None
    while 1:
        start_index = response.find("--CloudFront".encode("utf-8"), index)
        if index is not None:
            hash = [chunk[1] for chunk in chunk_ranges if chunk[0] == response[range_start_index:range_end_index].decode('utf-8')]
            data[hash[0]] = response[index:start_index - 2]


        content_range_index = response.find("Content-Range: bytes ".encode("utf-8"), start_index)

        range_start_index = content_range_index + len("Content-Range: bytes ")
        range_end_index = response.find("/".encode("utf-8"), content_range_index)

        before_end_index = response.find("\n".encode("utf-8"), content_range_index)
        end_index = response.find("\n".encode("utf-8"), before_end_index + 1)

        if end_index == -1:
            break

        index = end_index + 1


    return data


def is_file_up_to_date(file):
    file_path = os.path.join(output_folder, file.Name().decode("utf-8"))
    try:
        os.stat(file_path)
    except FileNotFoundError:
        return False

    with open(file_path, 'rb') as f:
        if file.ChunksLength():
            for i in range(file.ChunksLength()):
                chunk = file.Chunks(i)

                f.seek(chunk.Offset())
                file_chunk = f.read(chunk.Size())
                chunk_hash = hashlib.sha1(file_chunk).hexdigest()


                if chunk_hash != to_hex_string(chunk.HashAsNumpy().tobytes()):
                    return False
        else:
            f.seek(0)
            file_chunk = f.read(file.Size())
            file_hash = hashlib.sha1(file_chunk).hexdigest()

            if file_hash != to_hex_string(file.HashAsNumpy().tobytes()):
                return False
    return True


def is_file_interesting(file):
    name = file.Name().decode("utf-8")
    if "DofusInvoker.swf" in name or ".d2o" in name or".d2i" in name:
        return True
    return False


def get_files_to_download(manifest):
    files = []
    for i in range(manifest.FragmentsLength()):
        fragment = manifest.Fragments(i)

        for j in range(fragment.FilesLength()):
            file = fragment.Files(j)
            if is_file_interesting(file) and not is_file_up_to_date(file):
                files.append(file.Name().decode("utf-8"))

    return files


def main():
    latest_version = get_latest_version()
    manifest = get_manifest(latest_version)
    files_to_download = get_files_to_download(manifest)
    print("Updating", len(files_to_download), "files")
    parse_fragments(manifest, files_to_download)


if __name__ == "__main__":
    main()
