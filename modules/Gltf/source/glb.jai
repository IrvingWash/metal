#scope_module

load_glb_from_file :: (path: string) -> error: string, json: string, binary: []u8 {
    file, ok := file_open(path);
    RETURN_EMPTY_IF(!ok, "Failed to open file at '%'", path);
    defer file_close(*file);
    actual_file_length:, ok = file_length(file);
    RETURN_EMPTY_IF(!ok, "Failed to get the size of the file at '%'", path);

    total_read_bytes: int;

    header: Header;
    ok =, this_time_read_bytes := file_read(file, *header, Header.SPEC_BYTE_SIZE);
    RETURN_EMPTY_IF(!ok, "Failed to read file at '%'", path);
    total_read_bytes += this_time_read_bytes;
    RETURN_EMPTY_IF(
        header.magic != MAGIC,
        "The file at '%' doesn't comply to the GLTF 2.0 spec: actual magic is '%', expected: '%'",
        path,
        header.magic,
        MAGIC,
    );
    RETURN_EMPTY_IF(
        header.version != SUPPORTED_VERSION,
        "Only gltf binary container format of version '%' is supported, but file at '%' contained version '%'",
        SUPPORTED_VERSION,
        path,
        header.version,
    );
    RETURN_EMPTY_IF(
        header.length > actual_file_length,
        "The size of the file at '%' is less than the size stated in the header",
        path,
    );

    first_chunk_header: Chunk_Header;
    ok, this_time_read_bytes = file_read(file, *first_chunk_header, Chunk_Header.SPEC_BYTE_SIZE);
    RETURN_EMPTY_IF(!ok, "Failed to read file at '%'", path);
    total_read_bytes += this_time_read_bytes;
    RETURN_EMPTY_IF(
        first_chunk_header.type != Chunk_Type.JSON,
        "The file at '%' is not a single glb file, because it's first chunk is not a json chunk",
        path,
    );
    RETURN_EMPTY_IF(
        first_chunk_header.length + total_read_bytes > header.length,
        "The file at '%' is malformed: % chunk ends at % while the header states a smaller length (%)",
        path,
        first_chunk_header.type,
        first_chunk_header.length + total_read_bytes,
        header.length,
    );

    json := string.{
        data  = alloc(first_chunk_header.length,, temp),
        count = first_chunk_header.length,
    };
    ok, this_time_read_bytes = file_read(file, json.data, json.count);
    RETURN_EMPTY_IF(!ok, "Failed to read file at '%'", path);
    total_read_bytes += this_time_read_bytes;

    binary: []u8;
    if total_read_bytes + Chunk_Header.SPEC_BYTE_SIZE < header.length {
        second_chunk_header: Chunk_Header;
        ok, this_time_read_bytes = file_read(file, *second_chunk_header, Chunk_Header.SPEC_BYTE_SIZE);
        RETURN_EMPTY_IF(!ok, "Failed to read file at '%'", path);
        total_read_bytes += this_time_read_bytes;
        RETURN_EMPTY_IF(
            second_chunk_header.length + total_read_bytes > header.length,
            "The file at '%' is malformed: % chunk ends at % while the header states a smaller length (%)",
            path,
            second_chunk_header.type,
            second_chunk_header.length + total_read_bytes,
            header.length,
        );

        if second_chunk_header.type == Chunk_Type.BIN {
            binary = NewArray(second_chunk_header.length, u8, initialized = false);
            ok = file_read(file, binary.data, binary.count);
            if !ok {
                array_free(binary);
            }
            RETURN_EMPTY_IF(!ok, "Failed to read file at '%'", path);
        };
    }

    return "", json, binary;
}



#scope_file

MAGIC             :: 0x46546C67;
SUPPORTED_VERSION :: 2;

Header :: struct {
    magic: u32;
    version: u32;
    length: u32;

    SPEC_BYTE_SIZE :: 12;
}

Chunk_Header :: struct {
    length: u32;
    type:   Chunk_Type;

    SPEC_BYTE_SIZE :: 8;
}

Chunk_Type :: enum u32 {
    JSON :: 0x4E4F534A;
    BIN  :: 0x004E4942;
}

RETURN_EMPTY_IF :: (condition: bool, format: string, args: ..Any) #expand {
    if condition {
        `return
            tprint(format, ..args),
            "",
            .[];
    }
} @PrintLike

#assert(size_of(Header)       == Header.SPEC_BYTE_SIZE);
#assert(size_of(Chunk_Header) == Chunk_Header.SPEC_BYTE_SIZE);
