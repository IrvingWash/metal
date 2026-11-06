#import "Basic";
#import "File";
#import "Compiler";
#import "String";
#import "BuildCpp";
#import "Bindings_Generator";

MIKKTSPACE_DIR_PATH :: #run path_join(#filepath, "..", "vendored", "MikkTSpace",, temp);
MIKKTSPACE_C_PATH   :: #run path_join(MIKKTSPACE_DIR_PATH, "mikktspace.c",, temp);
MIKKTSPACE_H_PATH   :: #run path_join(MIKKTSPACE_DIR_PATH, "mikktspace.h",, temp);

OUTPUT_DIR_PATH :: #run path_join(#filepath, tprint("%", OS),, temp);
OUTPUT_BIN_NAME :: "libmikktspace";
OUTPUT_BIN_PATH     :: #run path_join(OUTPUT_DIR_PATH, OUTPUT_BIN_NAME,, temp);

#run {
    set_build_options_dc({
        do_output           = false,
        write_added_strings = false,
    });

    build_error := build();
    if build_error {
        log_error(build_error);
        exit(1);
    }

    bindings_error := generate_bindings();
    if bindings_error {
        log_error(bindings_error);
        exit(1);
    }
}

generate_bindings :: () -> error: string {
    output_filename := tprint("%.jai", OS);

    options: Generate_Bindings_Options;
    array_add(
        *options.library_search_paths,
        OUTPUT_DIR_PATH,
    );
    array_add(
        *options.libraries,
        Library.{
            filename   = OUTPUT_BIN_NAME,
            identifier = OUTPUT_BIN_NAME,
        },
    );
    options.generate_library_declarations = false;
    options.generate_compile_time_struct_checks = false;
    array_add(
        *options.include_paths,
        MIKKTSPACE_DIR_PATH,
    );
    array_add(
        *options.source_files,
        MIKKTSPACE_H_PATH,
    );

    ok := generate_bindings(options, output_filename);

    return ifx ok
        then ""
        else "Failed to generate bindings";
}

build :: () -> error: string {
    ok := make_directory_if_it_does_not_exist(OUTPUT_DIR_PATH);
    if !ok {
        return tprint("Failed to create directory %", OUTPUT_DIR_PATH);
    }

    ok = build_cpp_static_lib(
        OUTPUT_BIN_PATH,
        MIKKTSPACE_C_PATH,
        extra = .[
            "-fno-exceptions",
            "-fno-rtti",
            "-fno-threadsafe-statics",
            "-fPIC",
            tprint("-I%", MIKKTSPACE_DIR_PATH),
        ],
        debug = false,
    );

    return ifx ok
        then ""
        else "Failed to build";
}
