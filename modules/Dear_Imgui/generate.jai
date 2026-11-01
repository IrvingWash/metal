#import "Basic";
#import "File";
#import "String";
#import "Compiler";
#import "BuildCpp";

IMGUI_PATH          :: #run path_join(#filepath, "..", "vendored", "imgui",, temp);
IMGUI_BACKENDS_PATH :: #run path_join(#filepath, "..", "vendored", "imgui", "backends",, temp);

OUTPUT_PATH :: #run path_join(#filepath, tprint("%", OS),, temp);

VULKAN_INCLUDE_PATH :: #run path_join(#filepath, "..", "vendored", "Vulkan-Headers", "include",, temp);

#run,stallable {
    set_build_options_dc({ do_output = false });

    error := build();
    if error {
        log_error("Failed to build: %", error);
        exit(1);
    }
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
            ],
            debug = false,
        );
    } else {
        #assert false, "Unsupported OS";
    }

    return "";
}
