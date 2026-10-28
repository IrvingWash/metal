#import "Process";

#run {
    run_command(
        "cmake",
        "-GNinja",
        "-DCMAKE_BUILD_TYPE=Release",

    );
}
