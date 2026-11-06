#module_parameters()(AT_COMPILE_TIME := true);

#if AT_COMPILE_TIME {
    #run {
        set_build_options_dc({ do_output = false });

        for dep: DEPENDENCIES {
            error := clone_dependency(dep);
            if error {
                log_error("Failed :%", error);
                exit(1);
            }
        }

        error := generate_modules();
        if error {
            if error {
                log_error("Failed :%", error);
                exit(1);
            }
        }
    }
}

install_vendored :: () -> error: string {
    for dep: DEPENDENCIES {
        error := clone_dependency(dep);
        if error {
            return error;
        }
    }

    error := generate_modules();
    if error {
        if error {
            return error;
        }
    }

    return "";
}



#scope_module

MODULES_PATH  :: #run path_join(#filepath, "..", "modules",, temp);
VENDORED_PATH :: #run path_join(MODULES_PATH, "vendored",, temp);

Dependency :: struct {
    name:        string;
    git_url:     string;
    pin:         string;
    on_complete: () -> ok: bool;
}

Module_To_Generate :: struct {
    name:          string;
    relative_path: string;
}



#scope_file

#load "dependencies.jai";
#load "modules_to_generate.jai";

generate_modules :: () -> error: string {

    for module_metainfo: MODULES_TO_GENERATE {
        log("Generating %", module_metainfo.name);

        result := run_command(
            "jai",
            module_metainfo.relative_path,
            working_directory = MODULES_PATH,
        );

        if result.exit_code != 0 {
            return tprint("Failed to generate %", module_metainfo.name);
        }
    }

    return "";
}

clone_dependency :: (dep: Dependency) -> error: string {
    result := run_command(
        "git",
        "clone",
        "--shallow-submodules",
        "--depth", "1",
        "--branch", dep.pin,
        dep.git_url,
        path_join(VENDORED_PATH, dep.name,, temp),
    );
    if result.exit_code != 0 {
        return tprint("Failed to clone %", dep.name);
    }

    if dep.on_complete {
        error := dep.on_complete();
        if error {
            return tprint("Failed to run on_complete for %", dep.name);
        }
    }

    return "";
}

#import "Basic";
#import "Process";
#import "Compiler";
#import "String";
