Shader_Meta_Info :: struct {
    absolute_source_path: string;
    compiled_name:        string;
    entry_point_name:     string = "main";
    kind:                 Shaderc.Shader_Kind;
}

Shader_Kind :: Shaderc.Shader_Kind;

compile_shaders :: (
    optimization_type: Optimization_Type,
    output_root:       string,
    shader_meta_infos: []Shader_Meta_Info,
) -> error: string {
    ok := make_directory_if_it_does_not_exist(output_root, recursive = true);
    if !ok {
        return tprint("Failed to create directory at %", output_root);
    }

    compiler := Shaderc.compiler_initialize();
    defer Shaderc.compiler_release(compiler);

    compile_options := Shaderc.compile_options_initialize();
    defer Shaderc.compile_options_release(compile_options);

    Shaderc.compile_options_set_include_callbacks(
        compile_options,
        resolve_include,
        release_include_result,
        null,
    );

    Shaderc.compile_options_set_target_env(compile_options, .VULKAN, .VULKAN_1_4);
    Shaderc.compile_options_set_target_spirv(compile_options, ._1_6);
    if optimization_type < .OPTIMIZED {
        Shaderc.compile_options_set_generate_debug_info(compile_options);
        Shaderc.compile_options_set_optimization_level(compile_options, .ZERO);
        Shaderc.compile_options_set_warnings_as_errors(compile_options);
    } else {
        Shaderc.compile_options_set_optimization_level(compile_options, .PERFORMANCE);
    }

    for shader_meta_info: shader_meta_infos {
        content, ok := read_entire_file(shader_meta_info.absolute_source_path,, temp);
        if !ok {
            return tprint("Failed to read file at '%'", shader_meta_info.absolute_source_path);
        }

        compilation_result := Shaderc.compile_into_spv(
            compiler,
            content.data,
            cast(u64, content.count),
            shader_meta_info.kind,
            temp_c_string(shader_meta_info.absolute_source_path),
            temp_c_string(shader_meta_info.entry_point_name),
            compile_options,
        );
        defer Shaderc.result_release(compilation_result);

        compilation_status := Shaderc.result_get_compilation_status(compilation_result);
        if compilation_status != .SUCCESS {
            error_message := Shaderc.result_get_error_message(compilation_result);

            return copy_string(to_string(error_message),, temp);
        }
        if Shaderc.result_get_num_warnings(compilation_result) > 0 {
            log("%", to_string(Shaderc.result_get_error_message(compilation_result)));
        }

        size := Shaderc.result_get_length(compilation_result);
        bytes := Shaderc.result_get_bytes(compilation_result);

        compiled_path := path_join(output_root, shader_meta_info.compiled_name,, temp);
        ok = write_entire_file(compiled_path, bytes, cast(int, size));
        if !ok {
            return tprint("Failed to save spv at '%'", compiled_path);
        }
    }

    return "";
}

builder: String_Builder;

handle_gpu_structs :: (message: *Message) {
    if message.kind == {
        case .TYPECHECKED;
            typechecked := cast(*Message_Typechecked) message;

            for _struct: typechecked.structs {
                for note: _struct.expression.notes {
                    if note.text == GPU_NOTE {
                        tis := _struct.expression.defined_type;
                        log("% has @Gpu", tis.name);
                    }
                }
            }
    }
}



#scope_file

GPU_NOTE :: "Gpu";

resolve_include: Shaderc.Include_Resolve_Proc : (
    user_data:         *void,
    requested_source:  *u8,
    type:              Shaderc.Include_Type,
    requesting_source: *u8,
    include_depth:     u64,
) -> *Shaderc.Include_Result #c_call {
    push_context {
        result := New(Shaderc.Include_Result);

        requesting_source_root := path_strip_filename(to_string(requesting_source));
        requested_source_full_path := path_join(
            requesting_source_root,
            to_string(requested_source),,
            temp
        );

        file, ok := read_entire_file(requested_source_full_path,, temp);

        if !ok {
            message := tprint("Failed to read %", requested_source_full_path);
            result.content = message.data;
            result.content_length = xx message.count;
        }

        result.source_name = requested_source_full_path.data;
        result.source_name_length = xx requested_source_full_path.count;
        result.content = file.data;
        result.content_length = xx file.count;

        return result;
    }
}

release_include_result: Shaderc.Include_Result_Release_Proc : (
    user_data:      *void,
    include_result: *Shaderc.Include_Result,
) #c_call {
    // All temp
};

#import "Basic";
#import "File";
#import "Compiler";
#import "String";
Shaderc :: #import "Shaderc";
#import "Compiler";
#import "Math";
