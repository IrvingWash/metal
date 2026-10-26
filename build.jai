#scope_file

#import "Basic";
#import "Compiler";
#import "String";
#import "Metaprogram_Plugins";
#import "File";
#import "Process";

#import,file "compile_shaders.jai";

Config :: struct {
    should_help:             bool;
    should_generate_modules: bool;
    optimization_type:       Optimization_Type;
    plugins_to_create:       [..]Plugin_To_Create;
}

Flags :: struct {
    VERY_DEBUG       :: "--very-debug";
    DEBUG            :: "--debug";
    OPTIMIZED        :: "--optimized";
    VERY_OPTIMIZED   :: "--very-optimized";
    HELP             :: "--help";
    HELP_SHORT       :: "-h";
    GENERATE_MODULES :: "--generate-modules";
}

DEFAULT_PLUGINS_TO_CREATE :: Plugin_To_Create.[
    { name = "Check" },
];

EXECUTABLE_NAME :: "metal";

BUILD_ENTRY_FILE :: #run tprint("%source/main.jai", #filepath);

#run,stallable {
    defer reset_temporary_storage();

    set_build_options_dc({ do_output = false });

    build_options_dc := get_build_options();

    error, config := create_config(build_options_dc.compile_time_command_line);
    if error {
        fail_compilation_with_message("Failed to create config: %", error);
        return;
    }

    if config.should_help {
        help();
        return;
    }

    log("Generating modules...");
    if config.should_generate_modules {
        error := generate_modules();
        if error {
            fail_compilation_with_message("Failed to generate modules: %", error);
            return;
        }
    }

    output_path := tprint("%bin/%", #filepath, config.optimization_type);

    #if !#exists(JAILS_DIAGNOSTICS_BUILD) {
        log("Compiling shaders...");
        error = compile_shaders(config.optimization_type, output_path);
        if error {
            fail_compilation_with_message("Failed to compile shaders: %", error);
            return;
        }
    }

    log("Building...");
    error = build(build_options_dc, config, output_path);
    if error {
        fail_compilation_with_message("Failed to build: %", error);
        return;
    }
}

generate_modules :: () -> error: string {
    MODULES_TO_GENERATE :: struct { name: string; relative_path: string; }.[
        {
            name = "Vulkan_Memory_Allocator",
            relative_path = "modules/Vulkan_Memory_Allocator/generate.jai",
        },
        {
            name = "SDL3",
            relative_path = "modules/SDL3/generate.jai",
        }
    ];

    for module_metainfo: MODULES_TO_GENERATE {
        log("Generating %", module_metainfo.name);

        result := run_command(
            "jai",
            module_metainfo.relative_path,
            working_directory = #filepath,
        );

        if result.exit_code != 0 {
            return tprint("Failed to generate %", module_metainfo.name);
        }
    }

    return "";
}

build :: (
    build_options_dc: Build_Options,
    config:           Config,
    output_path:      string,
) -> error: string {
    log("Building in % mode", config.optimization_type);
    for plugin_to_create: config.plugins_to_create {
        log("'%' plugin enabled", plugin_to_create.name);
    }

    w := compiler_create_workspace(EXECUTABLE_NAME);

    { // Build options
        build_options := get_build_options(w);

        copy_commonly_propagated_fields(build_options_dc, *build_options);

        #if #exists(JAILS_DIAGNOSTICS_BUILD) {
            build_options.output_type = .NO_OUTPUT;
        } else {
            build_options.output_type = .EXECUTABLE;
        }
        build_options.output_executable_name = EXECUTABLE_NAME;
        build_options.write_added_strings    = true;
        build_options.intermediate_path      = output_path;
        build_options.output_path            = output_path;
        set_optimization(
            *build_options,
            config.optimization_type,
            preserve_debug_info = config.optimization_type >= .OPTIMIZED,
        );

        set_build_options(build_options, w);
    }

    ok := make_directory_if_it_does_not_exist(output_path, recursive = true);
    if !ok {
        return tprint("Failed to create build directory '%'", output_path);
    }

    // Building and managing plugins below
    intercept_flags: Intercept_Flags;

    plugins: [..]*Metaprogram_Plugin;
    plugins.allocator = temp;
    ok = init_plugins(config.plugins_to_create, *plugins, w);
    if !ok {
        return "Failed to init plugins";
    }

    for plugin: plugins {
        if plugin.before_intercept {
            plugin.before_intercept(plugin, *intercept_flags);
        }
    }

    compiler_begin_intercept(w, intercept_flags);

    add_build_file(BUILD_ENTRY_FILE, w);

    for plugin: plugins {
        if plugin.add_source {
            plugin.add_source(plugin);
        }
    }

    handle_compiler_messages(w, config, plugins);

    compiler_end_intercept(w);

    for plugin: plugins {
        if plugin.finish {
            plugin.finish(plugin);
        }

        if plugin.shutdown {
            plugin.shutdown(plugin);
        }
    }

    return "";
}

handle_compiler_messages :: (
    w:       Workspace,
    config:  Config,
    plugins: []*Metaprogram_Plugin,
) {
    while true {
        message := compiler_wait_for_message();

        for plugin: plugins {
            if plugin.message {
                plugin.message(plugin, message);
            }
        }

        try_to_fill_debug_placeholder(message, config, w);

        if message.kind == {
            case. COMPLETE;
                break;
        }
    }
}

try_to_fill_debug_placeholder :: (
    message: *Message,
    config:  Config,
    w:       Workspace,
) {
    if message.kind == {
        // Filling the placeholder without specifying the file leads to duplicate names
        case .FILE;
            file := cast(*Message_File, message);

            if file.fully_pathed_filename == BUILD_ENTRY_FILE {
                add_build_string(
                    tprint(
                        "DEBUG: bool : %;",
                        config.optimization_type <= .VERY_DEBUG,
                    ),
                    w,
                    file,
                );
            }
    }
}

create_config :: (arguments: []string) -> error: string, Config {
    config: Config;

    unknown_arguments: [..]string;
    unknown_arguments.allocator = temp;

    for argument: arguments {
        if argument == {
            case Flags.VERY_DEBUG;
                config.optimization_type = .VERY_DEBUG;
            case Flags.DEBUG;
                config.optimization_type = .DEBUG;
            case Flags.OPTIMIZED;
                config.optimization_type = .OPTIMIZED;
            case Flags.VERY_OPTIMIZED;
                config.optimization_type = .VERY_OPTIMIZED;
            case Flags.HELP; #through;
            case Flags.HELP_SHORT;
                config.should_help = true;
            case Flags.GENERATE_MODULES;
                config.should_generate_modules = true;
            case;
                PLUGIN_ARGUMENT_PREFIX ::  "+";

                if !starts_with(argument, PLUGIN_ARGUMENT_PREFIX) {
                    array_add(*unknown_arguments, argument);
                }
        }
    }

    if unknown_arguments.count > 0 {
        return tprint("Unknown arguments: %", unknown_arguments), config;
    }

    ok:, config.plugins_to_create = parse_plugin_arguments(arguments);
    if !ok {
        return "Failed to parse plugin arguments", config;
    }
    array_add(*config.plugins_to_create, ..DEFAULT_PLUGINS_TO_CREATE);

    return "", config;
}

help :: () {
    HELP_TEXT :: #string DONE
Usage:
    jai ./build.jai - [flag ...] [+plugin-name ...]

Example:
    jai ./build.jai - --very-optimized +Autorun +Iprof

Available flags:
    --very-debug       - build in very-debug mode
    --debug            - build in debug mode
    --optimized        - build in optimized mode
    --very-optimized   - build in very optimized mode

    --generate-modules - build binaries/generate bindings for modules

    --help, -h         - show this help
    DONE

    print(HELP_TEXT);
}

fail_compilation_with_message :: (format: string, args: ..Any) {
    log_error(format, ..args);
    compiler_set_workspace_status(.FAILED);
}
