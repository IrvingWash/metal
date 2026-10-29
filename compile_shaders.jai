compile_shaders :: (optimization_type: Optimization_Type, output_root: string) -> error: string {
    output_path := tprint("%/shaders", output_root);

    ok := make_directory_if_it_does_not_exist(output_path, recursive = true);
    if !ok {
        return tprint("Failed to create directory at %", output_path);
    }

    compiler := Shaderc.compiler_initialize();
    defer Shaderc.compiler_release(compiler);

    compile_options := Shaderc.compile_options_initialize();
    defer Shaderc.compile_options_release(compile_options);

    Shaderc.compile_options_set_target_env(compile_options, .VULKAN, .VULKAN_1_4);
    Shaderc.compile_options_set_target_spirv(compile_options, ._1_6);
    if optimization_type < .OPTIMIZED {
        Shaderc.compile_options_set_generate_debug_info(compile_options);
        Shaderc.compile_options_set_optimization_level(compile_options, .ZERO);
        Shaderc.compile_options_set_warnings_as_errors(compile_options);
    } else {
        Shaderc.compile_options_set_optimization_level(compile_options, .PERFORMANCE);
    }

    for shader_meta_info: SHADER_META_INFOS {
        absolute_source_path := path_join(#filepath, shader_meta_info.relative_source_path,, temp);

        content, ok := read_entire_file(absolute_source_path,, temp);
        if !ok {
            return tprint("Failed to read file at '%'", absolute_source_path);
        }

        compilation_result := Shaderc.compile_into_spv(
            compiler,
            content.data,
            cast(u64, content.count),
            shader_meta_info.kind,
            temp_c_string(absolute_source_path),
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

        compiled_path := path_join(output_path, shader_meta_info.compiled_name,, temp);
        ok = write_entire_file(compiled_path, bytes, cast(int, size));
        if !ok {
            return tprint("Failed to save spv at '%'", compiled_path);
        }
    }

    return "";
}



#scope_file

Shader_Meta_Info :: struct {
    relative_source_path: string;
    compiled_name:        string;
    entry_point_name:     string = "main";
    kind:                 Shaderc.Shader_Kind;
}

SHADER_META_INFOS :: Shader_Meta_Info.[
    {
        relative_source_path = "source/Renderer/shaders/dummy.fragment.glsl",
        compiled_name        = "dummy.fragment.spv",
        entry_point_name     = "main",
        kind                 = Shaderc.Shader_Kind.FRAGMENT_SHADER,
    },
    {
        relative_source_path = "source/Renderer/shaders/dummy.vertex.glsl",
        compiled_name        = "dummy.vertex.spv",
        entry_point_name     = "main",
        kind                 = Shaderc.Shader_Kind.VERTEX_SHADER,
    },
    {
        relative_source_path = "source/Renderer/shaders/common.vertex.glsl",
        compiled_name        = "common.vertex.spv",
        entry_point_name     = "main",
        kind                 = Shaderc.Shader_Kind.VERTEX_SHADER,
    },
    {
        relative_source_path = "source/Renderer/shaders/common.fragment.glsl",
        compiled_name        = "common.fragment.spv",
        entry_point_name     = "main",
        kind                 = Shaderc.Shader_Kind.FRAGMENT_SHADER,
    },
];

#import "Basic";
#import "File";
#import "Compiler";
#import "String";
Shaderc :: #import "Shaderc";
