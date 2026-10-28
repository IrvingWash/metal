#import "Compiler";
#import "Process";
#import "String";
#import "Basic";
#import "File";

SHADERC_PATH         :: #run path_join(#filepath, "shaderc",, temp);
BINARY_OUTPUT_PATH   :: #run path_join(#filepath, tprint("%", OS),, temp);
CMAKE_ARTEFACTS_PATH :: #run path_join(#filepath, "cmake_build",, temp);

#run {
    set_build_options_dc({ do_output = false });

    result := run_command(
        "python3",
        path_join(SHADERC_PATH, "utils", "git-sync-deps",, temp),
    );
    if result.exit_code != 0 {
        log_error("Failed\n");
        exit(1);
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
            log_error("Failed\n");
            exit(1);
        }

        result = run_command(
            "cmake",
            "--build", CMAKE_ARTEFACTS_PATH,
            "--target", "shaderc_shared",
        );
        if result.exit_code != 0 {
            log_error("Failed\n");
            exit(1);
        }
    } else {
        #assert false, "Unsupported OS";
    }

    delete_directory(CMAKE_ARTEFACTS_PATH);
}
