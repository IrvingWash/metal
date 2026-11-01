#import "Basic";
#import "File";
#import "String";
#import "Compiler";
#import "BuildCpp";
#import "Bindings_Generator";

IMGUI_PATH          :: #run path_join(#filepath, "..", "vendored", "imgui",, temp);
IMGUI_BACKENDS_PATH :: #run path_join(#filepath, "..", "vendored", "imgui", "backends",, temp);

OUTPUT_PATH :: #run path_join(#filepath, tprint("%", OS),, temp);

VULKAN_INCLUDE_PATH :: #run path_join(#filepath, "..", "vendored", "Vulkan-Headers", "include",, temp);
SDL_INCLUDE_PATH    :: #run path_join(#filepath, "..", "vendored", "SDL", "include",, temp);

#run,stallable {
    set_build_options_dc({ do_output = false });

/*
    error := build();
    if error {
        log_error("Failed to build: %", error);
        exit(1);
    }
    */

    error := generate_bindings();
    if error {
        log_error("Failed to generate bindings: %", error);
        exit(1);
    }
}

generate_bindings :: () -> error: string {
    output_file_name := tprint("%.jai", OS);

    options: Generate_Bindings_Options;
    array_add(
        *options.library_search_paths,
        OUTPUT_PATH,
    );
    array_add(
        *options.libraries,
        Library.{
            filename   = "libimgui",
            identifier = "libimgui",
        },
    );
    options.generate_library_declarations = false;
    options.generate_compile_time_struct_checks = false;
    array_add(
        *options.include_paths,
        IMGUI_PATH,
        IMGUI_BACKENDS_PATH,
    );
    array_add(
        *options.source_files,
        path_join(IMGUI_PATH, "imgui.h",, temp),
    );
    array_add(
        *options.extra_clang_arguments,
        "-x",
        "c++",
        "-DWIN32_LEAN_AND_MEAN",
    );
    options.auto_detect_enum_prefixes = false;
    options.strip_flags |= .INLINED_FUNCTIONS;

    ok := generate_bindings(options, output_file_name);
    if !ok {
        return "Failed to generate bindings";
    }

    return "";
}

build :: () -> error: string {
    imgui_src_files := string.[
        path_join(IMGUI_PATH, "imgui.cpp",,         temp),
        path_join(IMGUI_PATH, "imgui_draw.cpp",,    temp),
        path_join(IMGUI_PATH, "imgui_tables.cpp",,  temp),
        path_join(IMGUI_PATH, "imgui_widgets.cpp",, temp),

        path_join(IMGUI_BACKENDS_PATH, "imgui_impl_sdl3.cpp"),
        path_join(IMGUI_BACKENDS_PATH, "imgui_impl_vulkan.cpp"),
    ];

    ok := make_directory_if_it_does_not_exist(OUTPUT_PATH);
    if !ok {
        return tprint(
            "Failed to create directory at %",
            OUTPUT_PATH,
        );
    }

    #if OS == .LINUX {
        build_cpp_static_lib(
            path_join(OUTPUT_PATH, "libimgui"),
            ..imgui_src_files,
            extra = .[
                "-fno-exceptions",
                "-fno-rtti",
                "-fno-threadsafe-statics",
                "-fPIC",
                tprint("-I%", IMGUI_PATH),
                tprint("-I%", VULKAN_INCLUDE_PATH),
                tprint("-I%", SDL_INCLUDE_PATH),
            ],
            debug = false,
        );
    } else {
        #assert false, "Unsupported OS";
    }

    return "";
}
