#module_parameters(DEBUG: bool = false);

#load "source/gltf_types.jai";

// Use this if the scene is exported into both .gltf and .glb files.
parse_gltf :: (gltf: string, glb: []u8) -> error: string, Gltf {
    // @Todo
    return "", Gltf.{};
}

// Use this if the scene is exported into a single .glb file.
parse_glb :: (glb: []u8) -> error: string, Gltf {
    // @Todo
    return "", Gltf.{};
}

// Use this if the scene is exported into both .gltf and .glb files.
load_gltf :: (path: string) -> error: string, Gltf {
    root, file_name := path_decomp(path);

    json, ok := read_entire_file(path,, temp);
    if !ok {
        return
            tprint("Failed to read file at '%'", path),
            Gltf.{};
    }

    glb_path := path_join(root, file_name, GLB_EXTENSION,, temp);
    binary:, ok = read_entire_file(glb_path);
    if !ok {
        return
            tprint("Failed to read a .glb file based on the .gltf path '%'. The attempted path was '%'", path, glb_path),
            Gltf.{};
    }

    error, gltf := parse_gltf(json, cast([]u8, binary));

    return error, gltf;
}

// Use this if the scene is exported into a single .glb file.
load_glb :: (path: string) -> error: string, Gltf {
    file, ok := file_open(path);
    if !ok {
        return
            tprint("Failed to open file at '%'", path),
            Gltf.{};
    }
    defer file_close(*file);

    total_read_bytes: int;

    header: Glb.Header;
    ok =, this_time_read_bytes := file_read(file, *header, Glb.Header.SPEC_BYTE_SIZE);
    if !ok {
        return
            tprint("Failed to read file at '%'", path),
            Gltf.{};
    }
    total_read_bytes += this_time_read_bytes;
    if header.magic != Glb.MAGIC {
        return
            tprint(
                "The file at '%' doesn't comply to the GLTF 2.0 spec: actual magic is '%', expected: '%'",
                path,
                header.magic,
                Glb.MAGIC,
            ),
            Gltf.{};
    }
    if header.version != Glb.SUPPORTED_VERSION {
        return
            tprint(
                "Only gltf binary container format of version '%' is supported, but file at '%' contained version '%'",
                Glb.SUPPORTED_VERSION,
                path,
                header.version,
            ),
            Gltf.{};
    }

    first_chunk_header: Glb.Chunk_Header;
    ok, this_time_read_bytes = file_read(file, *first_chunk_header, Glb.Chunk_Header.SPEC_BYTE_SIZE);
    if !ok {
        return
            tprint("Failed to read file at '%'", path),
            Gltf.{};
    }
    total_read_bytes += this_time_read_bytes;
    if first_chunk_header.type != Glb.Chunk_Type.JSON {
        return
            tprint("The file at '%' is not a single glb file, because it's first chunk is not a json chunk", path),
            Gltf.{};
    };

    json := string.{
        data  = alloc(first_chunk_header.length,, temp),
        count = first_chunk_header.length,
    };
    ok, this_time_read_bytes = file_read(file, json.data, json.count);
    if !ok {
        return
            tprint("Failed to read file at '%'", path),
            Gltf.{};
    }
    total_read_bytes += this_time_read_bytes;

    binary: []u8;
    if total_read_bytes + Glb.Chunk_Header.SPEC_BYTE_SIZE < header.length {
        second_chunk_header: Glb.Chunk_Header;
        ok = file_read(file, *second_chunk_header, Glb.Chunk_Header.SPEC_BYTE_SIZE);
        if !ok {
            return
                tprint("Failed to read file at '%'", path),
                Gltf.{};
        }

        if second_chunk_header.type == Glb.Chunk_Type.BIN {
            binary = NewArray(second_chunk_header.length, u8, initialized = false);
            ok = file_read(file, binary.data, binary.count);
            if !ok {
                return
                    tprint("Failed to read file at '%'", path),
                    Gltf.{};
            }
        };
    }

    error, gltf := parse_gltf(json, binary);

    return error, gltf;
}



#scope_file

GLTF_EXTENSION :: ".gltf";
GLB_EXTENSION  :: ".glb";

#import "Basic";
#import "File";
#import "String";
Glb :: #import,file "source/glb.jai"(DEBUG);
