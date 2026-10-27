#load "gltf.jai";

// Use this if the scene is exported into both .gltf and .glb files.
parse_gltf :: (gltf: string, glb: []u8) -> Gltf {
}

// Use this if the scene is exported into a single .glb file.
parse_glb :: (glb: []u8) -> Gltf {
}

load_gltf :: (path: string) -> error: string, Gltf {
    extension := path_extension(path);
    normalized_extension := to_lower_copy(extension,, temp);

    error: string = ---;
    gltf:  Gltf   = ---;
    if normalized_extension == {
        case ".gltf";
            error, gltf = parse_gltf();
        case ".glb";
            error, gltf = parse_glb();
        case;
            error = tprint("Extension '%' is unsupported", extension);
    }

    return error, gltf;
}



#scope_file

#import "File";
#import "String";
