#scope_file

#import "Basic";
#import "Compiler";
#import "Process";
#import "File";

SDL_PATH :: "./SDL";

#run {
    set_build_options_dc({
        do_output = false,
        write_added_strings = false
    });

    error := build();
    if error {
        print("Failed to build SDL library: %", error, to_standard_error = true);
        exit(1);
    }
}

build :: () -> error: string {
    absolute_install_path := tprint("%%", #filepath, OS);
    {
        ok := make_directory_if_it_does_not_exist(absolute_install_path);
        if !ok {
            return tprint("Failed to create install directory at %", absolute_install_path);
        }
    }

    absolute_artefact_path := tprint("%/artefacts", absolute_install_path);
    {
        ok := make_directory_if_it_does_not_exist(absolute_artefact_path);
        if !ok {
            return tprint("Failed to create artefacts directory at %", absolute_artefact_path);
        }
    }

    absolute_sdl_path := get_absolute_path(SDL_PATH);

    { // Configuring cmake
        #if OS_IS_UNIX {
            config_command := string.[
                "cmake",
                "-S", absolute_sdl_path,
                "-B", absolute_artefact_path,
                tprint("-DCMAKE_INSTALL_PREFIX=%", absolute_install_path),
                tprint("-DCMAKE_PREFIX_PATH=%", absolute_install_path),
                "-DCMAKE_BUILD_TYPE=Release",
                "-DSDL_STATIC=ON",
                "-DSDL_SHARED=OFF",
            ];
        } else if OS == .WINDOWS {
            config_command := string.[
                "cmake",
                "-S", absolute_sdl_path,
                "-B", absolute_artefact_path,
                tprint("-DCMAKE_INSTALL_PREFIX=%", absolute_install_path),
                tprint("-DCMAKE_PREFIX_PATH=%", absolute_install_path),
                "-DSDL_STATIC=ON",
                "-DSDL_SHARED=OFF",
                "-DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded",
                "-DSDL_LIBC=OFF",
            ];
        } else {
            #assert false, "Unsupported OS";
        }

        result, _, error, _ := run_command(
            ..config_command,
            capture_and_return_output = true,
        );
        if error {
            return error;
        }
        if result.exit_code != 0 {
            return "Failed to configure cmake";
        }
    }

    { // Build SDL
        result, _, error, _ := run_command(
            ..string.[
                "cmake",
                "--build",
                absolute_artefact_path,
                "--config", "Release",
            ],
            capture_and_return_output = true,
        );
        if error {
            return error;
        }
        if result.exit_code != 0 {
            return "Failed to install SDL";
        }
    }

    { // Install SDL
        result, _, error, _ := run_command(
            ..string.["cmake", "--install", absolute_artefact_path, "--config", "Release"],
            capture_and_return_output = true,
        );
        if error {
            return error;
        }
        if result.exit_code != 0 {
            return "Failed to install SDL";
        }
    }

    delete_directory(tprint("%/include", absolute_install_path));
    delete_directory(tprint("%/lib/cmake", absolute_install_path));
    delete_directory(tprint("%/lib/pkgconfig", absolute_install_path));

    return "";
}
