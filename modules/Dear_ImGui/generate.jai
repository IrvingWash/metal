#import "Basic";
#import "File";
#import "String";
#import "Compiler";
#import "BuildCpp";
#import "Bindings_Generator";
#import "Hash_Table";

IMGUI_PATH          :: #run path_join(#filepath, "..", "vendored", "imgui",, temp);
IMGUI_BACKENDS_PATH :: #run path_join(#filepath, "..", "vendored", "imgui", "backends",, temp);

OUTPUT_PATH :: #run path_join(#filepath, tprint("%", OS),, temp);

VULKAN_INCLUDE_PATH :: #run path_join(#filepath, "..", "vendored", "Vulkan-Headers", "include",, temp);
SDL_INCLUDE_PATH    :: #run path_join(#filepath, "..", "vendored", "SDL", "include",, temp);

#run,stallable {
    set_build_options_dc({ do_output = false });

    error := build();
    if error {
        log_error("Failed to build: %", error);
        exit(1);
    }

    error = generate_bindings();
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
        VULKAN_INCLUDE_PATH,
        SDL_INCLUDE_PATH,
    );
    array_add(
        *options.source_files,
        path_join(IMGUI_PATH, "imgui.h",, temp),
        path_join(IMGUI_BACKENDS_PATH, "imgui_impl_sdl3.h",, temp),
        path_join(IMGUI_BACKENDS_PATH, "imgui_impl_vulkan.h",, temp),
    );
    array_add(
        *options.extra_clang_arguments,
        "-x",
        "c++",
        "-DWIN32_LEAN_AND_MEAN",
    );
    options.auto_detect_enum_prefixes = false;
    options.strip_flags |= .INLINED_FUNCTIONS;
    options.visitor = imgui_visitor;
    options.log_stripped_declarations = false;
    array_add(*options.flatten_namespaces, "ImGui");
    array_add(*options.strip_prefixes, "ImGui");

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
        path_join(IMGUI_PATH, "imgui_demo.cpp",,    temp),

        path_join(IMGUI_BACKENDS_PATH, "imgui_impl_sdl3.cpp",, temp),
        path_join(IMGUI_BACKENDS_PATH, "imgui_impl_vulkan.cpp",, temp),
    ];

    ok := make_directory_if_it_does_not_exist(OUTPUT_PATH);
    if !ok {
        return tprint(
            "Failed to create directory at %",
            OUTPUT_PATH,
        );
    }

    #if OS == .LINUX {
        ok = build_cpp_static_lib(
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
        if !ok {
            return "Failed to build ImGui";
        }
    } else {
        #assert false, "Unsupported OS";
    }

    return "";
}

begin_end_string_args: [..]*Declaration;
enums_for_typedefs: Table(string, *Enum);

imgui_visitor :: (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
    DECLARATIONS_TO_OMIT :: string.[
        "ImVec2",
        "ImVec4",
        "ImColor",
        "ImVector",
        "ImDrawCallback",

        "ImGuiTextBuffer",

        "ImDrawCallback_ResetRenderState",
    ];

    // ImGui has "typedef ints" for each enum. but we want to just use the enums directly,
    // so we get nice type safety, and .unary dots, etc.
    //
    // Look for declarations inside functions (i.e., arguments) or structs (i.e., fields)
    get_associated_enum_name :: (name: string) -> string {
        if name.count > 1 && name[name.count - 1] != #char "_" {
            return tprint("%_", name);
        }
        return name;
    }

    if !parent_decl {
        if array_find(DECLARATIONS_TO_OMIT, decl.name) {
            decl.decl_flags |= .OMIT_FROM_OUTPUT;
            return .STOP;
        }
        if decl.name == "ImGuiContext" {
            decl.output_name = decl.name; // Don’t shorten ImGuiContext to Context as this would conflict
        }

        if decl.kind == .TYPEDEF {
            old_name := decl.name;
            if old_name {
                new_name := get_associated_enum_name(old_name);
                for context.generator.global_scope.members {
                    if it.kind != .ENUM  || it.name != new_name     continue;

                    en := cast(*Enum)it;

                    // Don't output the integer typedef
                    decl.decl_flags |= .OMIT_FROM_OUTPUT;

                    // Make sure the enums like "FocusFlags_" get outputted as "FocusFlags"
                    if en.output_name.count > 2 && en.output_name[en.output_name.count - 1] == #char "_" {
                        en.output_name.count -= 1;
                    }

                    // Keep the comment, if there is one:
                    if decl.comment.text && !en.comment.text {
                        en.comment = decl.comment;
                    }

                    table_add(*enums_for_typedefs, old_name, en);
                    break;
                }
            }
        }
    }

    // Look for function arguments with "typedef" types.
    if parent_decl &&
        (parent_decl.kind == .FUNCTION || parent_decl.kind == .STRUCT) &&
        decl.kind == .DECLARATION && decl.type.type_of_typedef != null
    {
        old_name := decl.type.type_of_typedef.name;
        if old_name {
            found, en := table_find(*enums_for_typedefs, old_name);
            if found {
                change_type_to_enum(decl, en);
            }
        }
    }

    if decl.kind == .ENUM {
        // ImGui has lots of enums that should be enum flags. Luckily, they all end in "…Flags_".
        if ends_with(decl.name, "Flags_") {
            en := cast(*Enum)decl;
            en.flags |= .IS_ENUM_FLAGS;
            en.flags |= .VALUES_IN_HEX;
        }
    }

    if decl.kind == .FUNCTION {
        func := cast(*Function)decl;
        type := func.type.type_of_function;
        // ImGui also has functions with pairs of arguments like "text_begin" and "text_end"
        // for the pointers to the beginning and end of a string. We'll generate wrappers for
        // those function which take a jai string.
        //
        // Here we collect pointers to "_begin" arguments, and use them in
        // get_func_args_for_printing below.
        for type.arguments {
            if it_index == 0 || !ends_with(it.name, "_end")     continue;
            arg_type := find_underlying_type(it.type);
            if !arg_type.pointer_to || !(arg_type.pointer_to.number_flags & ._8BIT) continue; // Only convert *u8 ranges to string

            name_part := slice(it.name, 0, it.name.count - "_end".count);
            if !name_part   continue;

            // the first arg may appear as "text_begin" or just "text"
            name_part_with_begin := tprint("%_begin", name_part);
            prev_arg := type.arguments[it_index - 1];
            if prev_arg.name == name_part || prev_arg.name == name_part_with_begin {
                array_add(*begin_end_string_args, prev_arg);
                func.decl_flags |= .NEEDS_ARGUMENT_WRAPPER;
            }
        }
    }

    return .RECURSE;
}
