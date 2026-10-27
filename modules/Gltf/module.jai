#module_parameters(DEBUG: bool = false);

#load "source/gltf_types.jai";

/*
API

parse_gltf :: (gltf: string, glb: []u8) -> error: string, Gltf
parse_glb  :: (glb : []u8)              -> error: string, Gltf

load_gltf :: (path: string) -> error: string, Gltf
load_glb  :: (path: string) -> error: string, Gltf

Also all the types from source/gltf_types.jai
*/

// Use this if the scene is exported into both .gltf and .glb files.
parse_gltf :: (gltf: string, glb: []u8) -> error: string, Gltf {
    // @Todo
    return "", Gltf.{};
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

#import "Basic";
#import "File";
#import "String";

#load "source/glb.jai";
