compile_shaders :: (optimization_type: Optimization_Type, output_root: string) -> error: string {
    output_path := tprint("%/shaders", output_root);

    ok := make_directory_if_it_does_not_exist(output_path, recursive = true);
    if !ok {
        return tprint("Failed to create directory at %", output_path);
    }

    for shader: SHADERS {
        command: [..]string;
        command.allocator = temp;

        array_add(
            *command,
            "glslc",
            "--target-env=vulkan1.4",
            "--target-spv=spv1.6",
        );

        if optimization_type < .OPTIMIZED {
            array_add(
                *command,
                "-g",
                "-O0",
                "-Werror",
            );
        } else {
            array_add(
                *command,
                "-O",
            );
        }

        array_add(
            *command,
            tprint("-fshader-stage=%", get_stage_name(shader.stage)),
            tprint("%%", #filepath, shader.source_path),
            "-o",
            tprint("%/%", output_path, shader.compiled_name),
        );

        result, _, error := run_command(
            ..command,
            capture_and_return_output = true,
        );
        if result.exit_code != 0 || error {
            return tprint(
                "Failed to compile %: %",
                shader.source_path,
                error,
            );
        }
    }

    return "";
}



#scope_file

Shader :: struct {
    source_path:   string;
    compiled_name: string;
    stage:         Shader_Stage;
}

Shader_Stage :: enum {
    VERTEX;
    FRAGMENT;
}

get_stage_name :: (stage: Shader_Stage) -> string {
    if #complete stage == {
        case .VERTEX;
            return "vertex";
        case .FRAGMENT;
            return "fragment";
    }
}

SHADERS :: Shader.[
    {
        source_path   = "source/Renderer/shaders/dummy.fragment.glsl",
        compiled_name = "dummy.fragment.spv",
        stage         = .FRAGMENT,
    },
    {
        source_path   = "source/Renderer/shaders/dummy.vertex.glsl",
        compiled_name = "dummy.vertex.spv",
        stage         = .VERTEX,
    },
];

#import "Basic";
#import "File";
#import "Process";
#import "Compiler";
