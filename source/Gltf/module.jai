#module_parameters(DEBUG: bool = false);

#load "source/gltf_types.jai";

/*
API

parse_gltf :: (gltf: string) -> error: string, Gltf
parse_glb  :: (glb : []u8)   -> error: string, Gltf

load_gltf :: (path: string) -> error: string, Gltf
load_glb  :: (path: string) -> error: string, Gltf

Also all the types from source/gltf_types.jai
*/

// Use this if the scene is exported into both .gltf and .bin files.
parse_gltf :: (json: string) -> error: string, Gltf {
    ok, gltf := json_parse_string(json, Gltf);
    if !ok {
        return
            "Failed to parse JSON",
            Gltf.{};
    }

    { // Validations
        if split(gltf.asset.version, ".",, temp)[0] != SUPPORTED_GLTF_VERSION {
            return
                tprint(
                    "The provided gltf is of an unsupported version %",
                    gltf.asset.version,
                ),
                Gltf.{};
        }

        unsupported_extensions: [..]string;
        unsupported_extensions.allocator = temp;
        for required_extension: gltf.extensions_required {
            if !array_find(SUPPORTED_EXTENSIONS, required_extension) {
                array_add(*unsupported_extensions, required_extension);
            }
        }
        if unsupported_extensions.count > 0 {
            return
                tprint(
                    "The provided gltf requires the following unsupported extensions: %",
                    join(unsupported_extensions, ",",, temp),
                ),
                Gltf.{};
        }
    }

    return "", gltf;
}

// Use this if the scene is exported into a single .glb file.
parse_glb :: (glb: []u8) -> error: string, Gltf {
    error, json, binary := parse_glb_from_memory(glb);
    if error {
        return
            error,
            Gltf.{};
    }

    error =, gltf := parse_gltf(json, binary);
    return error, gltf;
}

// Use this if the scene is exported into both .gltf and .bin files.
load_gltf :: (path: string) -> error: string, Gltf {
    root, file_name := path_decomp(path);

    json, ok := read_entire_file(path,, temp);
    if !ok {
        return
            tprint("Failed to read file at '%'", path),
            Gltf.{};
    }

    bin_path := path_join(root, file_name, BIN_EXTENSION,, temp);
    binary:, ok = read_entire_file(bin_path);
    if !ok {
        return
            tprint(
                "Failed to read a .bin file based on the .gltf path '%'. The attempted path was '%'",
                path,
                bin_path,
            ),
            Gltf.{};
    }

    error, gltf := parse_gltf(json, cast([]u8, binary));

    return error, gltf;
}

// Use this if the scene is exported into a single .glb file.
load_glb :: (path: string) -> error: string, Gltf {
    error, json, binary := load_glb_from_file(path);
    if error {
        return
            error,
            Gltf.{};
    }

    error =, gltf := parse_gltf(json, binary);
    return error, gltf;
}



#scope_file

GLTF_EXTENSION :: ".gltf";
GLB_EXTENSION  :: ".glb";
BIN_EXTENSION  :: ".bin";

SUPPORTED_EXTENSIONS :: string.[];

#import "Basic";
#import "File";
#import "String";
#import "Jaison";

#load "source/glb.jai";
