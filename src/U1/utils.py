output_folder = './data/U/'

def to_hex_string(arr):
    return ''.join([f'{x:02x}' for x in arr])

def get_chunk_range(chunk):
    return f"{chunk.Offset()}-{chunk.Offset() + chunk.Size() - 1}", to_hex_string(chunk.HashAsNumpy().tobytes())
