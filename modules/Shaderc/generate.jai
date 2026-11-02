#import "Compiler";
#import "Process";
#import "String";
#import "Basic";
#import "File";

SHADERC_PATH :: #run path_join(#filepath, "..", "vendored", "shaderc",, temp);

BINARY_OUTPUT_PATH   :: #run path_join(#filepath, tprint("%", OS),, temp);
CMAKE_ARTEFACTS_PATH :: #run path_join(#filepath, "cmake_build",, temp);

#run {
    set_build_options_dc({ do_output = false });

    error := build();
    if error {
        log_error(error);
        exit(1);
    }
}

build :: () -> error: string {
    result := run_command(
        "python3",
        path_join(SHADERC_PATH, "utils", "git-sync-deps",, temp),
    );
    if result.exit_code != 0 {
        return "Failed to sync deps";
    }

    #if OS_IS_UNIX {
        result = run_command(
            "cmake",
            "-S", SHADERC_PATH,
            "-B", CMAKE_ARTEFACTS_PATH,
            "-G", "Ninja",
            "-DCMAKE_BUILD_TYPE=Release",
            "-DSHADERC_SKIP_TESTS=ON",
            "-DSHADERC_SKIP_EXAMPLES=ON",
            tprint("-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%", BINARY_OUTPUT_PATH),
        );
        if result.exit_code != 0 {
            return "Failed to configure cmake";
        }

        result = run_command(
            "cmake",
            "--build", CMAKE_ARTEFACTS_PATH,
            "--target", "shaderc_shared",
        );
        if result.exit_code != 0 {
            return "Failed to build";
        }
    } else #if OS == .WINDOWS {
       result = run_command(
           "cmake",
           "-S", SHADERC_PATH,
           "-B", CMAKE_ARTEFACTS_PATH,
           "-G", "Ninja",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DSHADERC_SKIP_TESTS=ON",
           "-DSHADERC_SKIP_EXAMPLES=ON",
           "-DCMAKE_CXX_FLAGS=-D_CRT_SECURE_NO_WARNINGS",
           tprint("-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=%", BINARY_OUTPUT_PATH),
           tprint("-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%", BINARY_OUTPUT_PATH),
       );
       if result.exit_code != 0 {
           return "Failed to configure cmake";
       }

       result = run_command(
           "cmake",
           "--build", CMAKE_ARTEFACTS_PATH,
           "--target", "shaderc_shared",
       );
       if result.exit_code != 0 {
           return "Failed to build";
       }
   } else {
       #assert false, "Unsupported OS";
   }
    ok := delete_directory(CMAKE_ARTEFACTS_PATH);
    if !ok {
        return tprint("Failed to delete artefacts directory at '%'", CMAKE_ARTEFACTS_PATH);
    }

    return "";
}
