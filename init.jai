#import "Compiler";
#import "Basic";

#import,file "scripts/install_vendored.jai"()(AT_COMPILE_TIME = false);
#import,file "scripts/install_tools.jai"()(AT_COMPILE_TIME = false);

#run {
    set_build_options_dc({ do_output = false });

    error := install_vendored();
    if error {
        log_error("Failed: %", error);
        exit(1);
    }

    install_tools();
}
