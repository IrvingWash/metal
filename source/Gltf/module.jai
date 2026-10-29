GLTF_EXTENSION :: ".gltf";
GLB_EXTENSION  :: ".glb";
BIN_EXTENSION  :: ".bin";

SUPPORTED_EXTENSIONS :: string.[];

DATA_URI_PREFIX :: "data:";

/*
API

read_gltf_from_file :: (path: string, $validate: bool = false) -> error: string, Gltf
read_glb_from_file  :: (path: string, $validate: bool = false) -> error: string, Gltf

Also all the types from gltf_types.jai
*/

#load "gltf_types.jai";

read_gltf_from_file :: (path: string, $validate: bool = false) -> error: string, Gltf {
    json, ok := read_entire_file(path,, temp);
    if !ok {
        return
            tprint("Failed to read file at '%'", path),
            Gltf.{};
    }

    error, gltf := parse_gltf(json);
    if error {
        return
            tprint(
                "Failed to parse gltf at '%': %",
                path,
                error
            ),
            gltf;
    }

    error = load_buffers_data(*gltf.buffers, path);
    if error {
        return
            tprint("Failed to load buffer data for '%': %", path, error),
            gltf;
    }

    #if validate {
        error = validate_gltf(gltf, path);
        if error {
            return
                error,
                gltf;
        }
    }

    return "", gltf;
}

read_glb_from_file :: (path: string, $validate: bool = false) -> error: string, Gltf {
    error, json, binary := parse_glb_from_file(path);
    if error {
        return
            error,
            Gltf.{};
    }

    error =, gltf := parse_gltf(json);
    if error {
        return
            tprint(
                "Failed to parse gltf of the glb at %: %",
                path,
                error,
            ),
            gltf;
    }

    if gltf.buffers.count == {
        case 0;
            if binary.count != 0 {
                return
                    tprint("The glb at '%' has binary data, but no buffers", path),
                    gltf;
            }
        case;
            if binary.count != 0 {
                if gltf.buffers[0].uri {
                    return
                        tprint(
                            "The glb at '%' has a binary, but it's first buffer has a uri",
                            path,
                        ),
                        gltf;
                }

                gltf.buffers[0].bytes = binary;

                if gltf.buffers[0].bytes.count < gltf.buffers[0].byte_length {
                    return
                        tprint(
                            "The binary size of '%' is less than it's buffer's byte length",
                            path,
                        ),
                        gltf;
                }
            }

            error = load_buffers_data(*gltf.buffers, path);
            if error {
                return
                    tprint("Failed to load buffer data for '%': %", path, error),
                    gltf;
            }
    }

    #if validate {
        error = validate_gltf(gltf, path);
        if error {
            return
                error,
                gltf;
        }
    }

    return "", gltf;
}



#scope_file

load_buffers_data :: (buffers: *[]Buffer, main_file_path: string) -> error: string {
    root_path := path_strip_filename(main_file_path);

    for *buffer: buffers.* {
        if !buffer.uri {
            continue;
        }

        if !starts_with(buffer.uri, DATA_URI_PREFIX) {
            bin_path := ifx is_absolute_path(buffer.uri)
                then buffer.uri
                else path_join(root_path, buffer.uri,, temp);

            bin, ok := read_entire_file(bin_path);
            if !ok {
                return tprint("Failed to load bin file at '%'", bin_path);
            }

            buffer.bytes = cast([]u8, bin);

            if buffer.bytes.count < buffer.byte_length {
                return
                    tprint(
                        "The binary size of '%' is less than it's buffer's byte length",
                        bin_path,
                    );
            }
        } else {
            return tprint(
                "The gltf at % has data-uri binary, we don't support those",
                main_file_path,
            );
        }
    }

    return "";
}

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
                gltf;
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
                    join(..unsupported_extensions, separator = ",",, temp),
                ),
                gltf;
        }
    }

    return "", gltf;
}

#import "Basic";
#import "File";
#import "String";
#import "Jaison";

#load "glb.jai";
#load "gltf_validator.jai";
