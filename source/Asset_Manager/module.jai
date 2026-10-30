#module_parameters()(VALIDATE: bool = false);

Asset_Manager :: struct {
    root_path:    string;
    shaders_path: string;
}

init :: () -> Asset_Manager {
    asset_manager: Asset_Manager;

    asset_manager.root_path = copy_string(
        path_strip_filename(
            get_path_of_running_executable(),
        )
    );

    asset_manager.shaders_path = path_join(asset_manager.root_path, "shaders");

    return asset_manager;
}

deinit :: (asset_manager: *Asset_Manager) {
    free(asset_manager.root_path);
    free(asset_manager.shaders_path);

    asset_manager.* = {};
}

get_compiled_shader :: (asset_manager: Asset_Manager, name: string) -> error: string, string {
    path := path_join(asset_manager.shaders_path, name,, temp);

    content, ok := read_entire_file(path);
    if !ok {
        return
            tprint("Failed to read shader file at '%'", path),
            content;
    }

    return "", content;
}

// @Todo: In the future, this will just upload our own binaries.
// The convertation would be run via a script, like shader compilation
upload_model :: (path: string) -> error: string {
    model_dto: Option(Model_Dto);

    extension := path_extension(path);
    if array_find(GLTF_FILE_EXTENSIONS, extension) {
        error, result := convert_gltf(path, VALIDATE);
        if error {
            return error;
        }

        set(*model_dto, result);
    }

    if model_dto.kind == .NONE {
        return tprint("Unsupported model file extension: %", path);
    }

    // @Todo

    return "";
}



#scope_file

#import "Basic";
#import "System";
#import "String";
#import "Math";
#import "File";
#import "Option";

#load "model_dto.jai";
#load "gltf_converter.jai";
