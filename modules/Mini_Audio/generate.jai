#import "Basic";
#import "Compiler";
#import "BuildCpp";
#import "String";
#import "File";
#import "Bindings_Generator";

MINIAUDIO_PATH   :: #run path_join(#filepath, "..", "vendored", "miniaudio",, temp);
MINIAUDIO_C_PATH :: #run path_join(MINIAUDIO_PATH, "miniaudio.c",, temp);
MINIAUDIO_H_PATH :: #run path_join(MINIAUDIO_PATH, "miniaudio.h",, temp);

OUTPUT_DIR_PATH :: #run path_join(#filepath, tprint("%", OS),, temp);
OUTPUT_BIN_NAME :: "libminiaudio";
OUTPUT_BIN_PATH :: #run path_join(OUTPUT_DIR_PATH, OUTPUT_BIN_NAME,, temp);

#run {
    set_build_options_dc({
        do_output           = false,
        write_added_strings = false,
    });

    error := build();
    if error {
        print(error, to_standard_error = true);
        exit(1);
    }

    error = generate_bindings();
    if error {
        print(error, to_standard_error = true);
        exit(1);
    }
}

generate_bindings :: () -> error: string {
    output_file_name := tprint("GENERATED_%.jai", OS);

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
    options.generate_compile_time_struct_checks = true;
    array_add(
        *options.source_files,
        MINIAUDIO_H_PATH,
    );

    ok := generate_bindings(options, output_file_name);
    if !ok {
        return "Failed to generate bindings for miniaudio";
    }

    return "";
}

build :: () -> error: string {
    ok := make_directory_if_it_does_not_exist(OUTPUT_DIR_PATH);
    if !ok {
        return tprint("Failed to create directory at %", OUTPUT_DIR_PATH);
    }

    extras: [..]string;
    extras.allocator = temp;
    array_add(
        *extras,
        "-I",
        MINIAUDIO_H_PATH,
        "-fno-exceptions",
        "-fno-rtti",
    );

    ok = build_cpp_static_lib(
        OUTPUT_BIN_PATH,
        MINIAUDIO_C_PATH,
        extra = extras,
        debug = false,
        working_directory = #filepath,
    );

    if !ok {
        return "Failed to build miniaudio";
    }

    return "";
}
