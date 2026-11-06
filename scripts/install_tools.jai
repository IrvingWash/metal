#import "Basic";
#import "Compiler";
#import "File_Utilities";
#import "Process";
#import "String";

TOOLS_ABSOLUTE_PATH :: #run path_join(#filepath, "..", "tools",, temp);

HOOKS_SOURCE_ABSOLUTE_PATH      :: #run path_join(TOOLS_ABSOLUTE_PATH, "hooks",, temp);
HOOKS_DESTINATION_ABSOLUTE_PATH :: #run path_join(#filepath, "..", ".git/hooks",, temp);

#run,stallable {
    set_build_options_dc(.{
        do_output           = false,
        write_added_strings = false,
    });

    install_git_hooks();

    reset_temporary_storage();
}

install_git_hooks :: () {
    on_file :: (info: *File_Visit_Info, user_data: *void) {
        if info.is_directory {
            return;
        }

        resulting_path := path_join(
            HOOKS_DESTINATION_ABSOLUTE_PATH,
            info.short_name,,
            temp
        );

        copy_file(
            info.full_name,
            resulting_path,
        );

        make_executable(resulting_path);
    }

    visit_files(
        HOOKS_SOURCE_ABSOLUTE_PATH,
        recursive = false,
        user_data = null,
        proc = on_file,
    );
}

make_executable :: (path: string) {
    run_command(
        "chmod",
        "+x",
        path,
    );
}
