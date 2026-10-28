Asset_Manager :: struct {
    root_path: string;
    shaders_path: string;
}

asset_manager: Asset_Manager;

init :: () {
    exe_path := copy_string(get_path_of_running_executable());

    asset_manager.root_path = path_strip_filename(exe_path);
    asset_manager.shaders_path = path_join(asset_manager.root_path, "shaders");
}

deinit :: () {
    free(asset_manager.root_path);
    free(asset_manager.shaders_path);
}

read_shader_from_file :: (name: string) -> error: string, shader: string {
    path := path_join(asset_manager.shaders_path, name);

    content, ok := read_entire_file(path);
    if !ok {
        return
            tprint("Failed to read shader file at '%'", path),
            content;
    }

    return "", content;
}



#scope_file

#import "Basic";
#import "System";
#import "String";
#import "File";
