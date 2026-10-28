#scope_module

parse_glb_from_memory :: (user_provided_glb: []u8) -> error: string, json: string, binary: []u8 {
    RETURN_EMPTY_IF(
        user_provided_glb.count < (Header.SPEC_BYTE_SIZE + Chunk_Header.SPEC_BYTE_SIZE),
        "The provided glb is too small it can't even fit mandatory headers",
    );

    glb_view := user_provided_glb;

    header: *Header;
    {
        header = cast(*Header, glb_view.data);
        glb_view.data += Header.SPEC_BYTE_SIZE;
        glb_view.count -= Header.SPEC_BYTE_SIZE;
        RETURN_EMPTY_IF(
            header.magic != MAGIC,
            "The provided glb doesn't comply to the GLTF 2.0 spec: actual magic is '%', expected: '%'",
            header.magic,
            MAGIC,
        );
        RETURN_EMPTY_IF(
            header.version != SUPPORTED_GLB_VERSION,
            "Only gltf binary container format of version '%' is supported, but provided glb contained version '%'",
            SUPPORTED_GLB_VERSION,
            header.version,
        );
        RETURN_EMPTY_IF(
            header.length > user_provided_glb.count,
            "The size of the provided glb is less than the size stated in the header",
        );
    }

    json: string = ---;
    {
        first_chunk_header := cast(*Chunk_Header, glb_view.data);
        glb_view.data += Chunk_Header.SPEC_BYTE_SIZE;
        glb_view.count -= Chunk_Header.SPEC_BYTE_SIZE;
        RETURN_EMPTY_IF(
            first_chunk_header.type != Chunk_Type.JSON,
            "The provided glb is not a single glb file, because it's first chunk is not a json chunk",
        );
        RETURN_EMPTY_IF(
            first_chunk_header.length + (user_provided_glb.count - glb_view.count) > header.length,
            "The provided glb is malformed: % chunk ends at % while the header states a smaller length (%)",
            first_chunk_header.type,
            first_chunk_header.length + (user_provided_glb.count - glb_view.count),
            header.length,
        );

        json = string.{
            data  = glb_view.data,
            count = first_chunk_header.length,
        };
        glb_view.data += json.count;
        glb_view.count -= json.count;
    }

    binary: []u8;
    if (user_provided_glb.count - glb_view.count) + Chunk_Header.SPEC_BYTE_SIZE < header.length {
        second_chunk_header := cast(*Chunk_Header, glb_view.data);
        glb_view.data += Chunk_Header.SPEC_BYTE_SIZE;
        glb_view.count -= Chunk_Header.SPEC_BYTE_SIZE;

        if second_chunk_header.type == Chunk_Type.BIN {
            RETURN_EMPTY_IF(
                second_chunk_header.length + (user_provided_glb.count - glb_view.count) > header.length,
                "The provided glb is malformed: % chunk ends at % while the header states a smaller length (%)",
                second_chunk_header.type,
                second_chunk_header.length + (user_provided_glb.count - glb_view.count),
                header.length,
            );

            binary.data = glb_view.data;
            binary.count = second_chunk_header.length;
        }
    }

    return "", json, binary;
}

parse_glb_from_file :: (path: string) -> error: string, json: string, binary: []u8 {
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
        header.version != SUPPORTED_GLB_VERSION,
        "Only gltf binary container format of version '%' is supported, but file at '%' contained version '%'",
        SUPPORTED_GLB_VERSION,
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

        if second_chunk_header.type == Chunk_Type.BIN {
            RETURN_EMPTY_IF(
                second_chunk_header.length + total_read_bytes > header.length,
                "The file at '%' is malformed: % chunk ends at % while the header states a smaller length (%)",
                path,
                second_chunk_header.type,
                second_chunk_header.length + total_read_bytes,
                header.length,
            );

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
SUPPORTED_GLB_VERSION :: 2;

Header :: struct {
    magic:   u32;
    version: u32;
    length:  u32; // The length of the whole thing, includes everything

    SPEC_BYTE_SIZE :: 12;
}

Chunk_Header :: struct {
    length: u32; // The length of the data itself, doesn't include this headers size
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
