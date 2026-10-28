Source_Language :: enum u32 {
    GLSL :: 0;
    HLSL :: 1;
}

Shader_Kind :: enum u32 {
    VERTEX_SHADER                       :: 0;
    FRAGMENT_SHADER                     :: 1;
    COMPUTE_SHADER                      :: 2;
    GEOMETRY_SHADER                     :: 3;
    TESS_CONTROL_SHADER                 :: 4;
    TESS_EVALUATION_SHADER              :: 5;

    GLSL_VERTEX_SHADER                  :: 0;
    GLSL_FRAGMENT_SHADER                :: 1;
    GLSL_COMPUTE_SHADER                 :: 2;
    GLSL_GEOMETRY_SHADER                :: 3;
    GLSL_TESS_CONTROL_SHADER            :: 4;
    GLSL_TESS_EVALUATION_SHADER         :: 5;

    GLSL_INFER_FROM_SOURCE              :: 6;

    GLSL_DEFAULT_VERTEX_SHADER          :: 7;
    GLSL_DEFAULT_FRAGMENT_SHADER        :: 8;
    GLSL_DEFAULT_COMPUTE_SHADER         :: 9;
    GLSL_DEFAULT_GEOMETRY_SHADER        :: 10;
    GLSL_DEFAULT_TESS_CONTROL_SHADER    :: 11;
    GLSL_DEFAULT_TESS_EVALUATION_SHADER :: 12;
    SPIRV_ASSEMBLY                      :: 13;
    RAYGEN_SHADER                       :: 14;
    ANYHIT_SHADER                       :: 15;
    CLOSESTHIT_SHADER                   :: 16;
    MISS_SHADER                         :: 17;
    INTERSECTION_SHADER                 :: 18;
    CALLABLE_SHADER                     :: 19;
    GLSL_RAYGEN_SHADER                  :: 14;
    GLSL_ANYHIT_SHADER                  :: 15;
    GLSL_CLOSESTHIT_SHADER              :: 16;
    GLSL_MISS_SHADER                    :: 17;
    GLSL_INTERSECTION_SHADER            :: 18;
    GLSL_CALLABLE_SHADER                :: 19;
    GLSL_DEFAULT_RAYGEN_SHADER          :: 20;
    GLSL_DEFAULT_ANYHIT_SHADER          :: 21;
    GLSL_DEFAULT_CLOSESTHIT_SHADER      :: 22;
    GLSL_DEFAULT_MISS_SHADER            :: 23;
    GLSL_DEFAULT_INTERSECTION_SHADER    :: 24;
    GLSL_DEFAULT_CALLABLE_SHADER        :: 25;
    TASK_SHADER                         :: 26;
    MESH_SHADER                         :: 27;
    GLSL_TASK_SHADER                    :: 26;
    GLSL_MESH_SHADER                    :: 27;
    GLSL_DEFAULT_TASK_SHADER            :: 28;
    GLSL_DEFAULT_MESH_SHADER            :: 29;
}

Profile :: enum u32 {
    NONE          :: 0;

    CORE          :: 1;
    COMPATIBILITY :: 2;
    ES            :: 3;
}

Optimization_Level :: enum u32 {
    ZERO        :: 0;
    SIZE        :: 1;
    PERFORMANCE :: 2;
}

Limit :: enum u32 {
    MAX_LIGHTS                                    :: 0;
    MAX_CLIP_PLANES                               :: 1;
    MAX_TEXTURE_UNITS                             :: 2;
    MAX_TEXTURE_COORDS                            :: 3;
    MAX_VERTEX_ATTRIBS                            :: 4;
    MAX_VERTEX_UNIFORM_COMPONENTS                 :: 5;
    MAX_VARYING_FLOATS                            :: 6;
    MAX_VERTEX_TEXTURE_IMAGE_UNITS                :: 7;
    MAX_COMBINED_TEXTURE_IMAGE_UNITS              :: 8;
    MAX_TEXTURE_IMAGE_UNITS                       :: 9;
    MAX_FRAGMENT_UNIFORM_COMPONENTS               :: 10;
    MAX_DRAW_BUFFERS                              :: 11;
    MAX_VERTEX_UNIFORM_VECTORS                    :: 12;
    MAX_VARYING_VECTORS                           :: 13;
    MAX_FRAGMENT_UNIFORM_VECTORS                  :: 14;
    MAX_VERTEX_OUTPUT_VECTORS                     :: 15;
    MAX_FRAGMENT_INPUT_VECTORS                    :: 16;
    MIN_PROGRAM_TEXEL_OFFSET                      :: 17;
    MAX_PROGRAM_TEXEL_OFFSET                      :: 18;
    MAX_CLIP_DISTANCES                            :: 19;
    MAX_COMPUTE_WORK_GROUP_COUNT_X                :: 20;
    MAX_COMPUTE_WORK_GROUP_COUNT_Y                :: 21;
    MAX_COMPUTE_WORK_GROUP_COUNT_Z                :: 22;
    MAX_COMPUTE_WORK_GROUP_SIZE_X                 :: 23;
    MAX_COMPUTE_WORK_GROUP_SIZE_Y                 :: 24;
    MAX_COMPUTE_WORK_GROUP_SIZE_Z                 :: 25;
    MAX_COMPUTE_UNIFORM_COMPONENTS                :: 26;
    MAX_COMPUTE_TEXTURE_IMAGE_UNITS               :: 27;
    MAX_COMPUTE_IMAGE_UNIFORMS                    :: 28;
    MAX_COMPUTE_ATOMIC_COUNTERS                   :: 29;
    MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS            :: 30;
    MAX_VARYING_COMPONENTS                        :: 31;
    MAX_VERTEX_OUTPUT_COMPONENTS                  :: 32;
    MAX_GEOMETRY_INPUT_COMPONENTS                 :: 33;
    MAX_GEOMETRY_OUTPUT_COMPONENTS                :: 34;
    MAX_FRAGMENT_INPUT_COMPONENTS                 :: 35;
    MAX_IMAGE_UNITS                               :: 36;
    MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS :: 37;
    MAX_COMBINED_SHADER_OUTPUT_RESOURCES          :: 38;
    MAX_IMAGE_SAMPLES                             :: 39;
    MAX_VERTEX_IMAGE_UNIFORMS                     :: 40;
    MAX_TESS_CONTROL_IMAGE_UNIFORMS               :: 41;
    MAX_TESS_EVALUATION_IMAGE_UNIFORMS            :: 42;
    MAX_GEOMETRY_IMAGE_UNIFORMS                   :: 43;
    MAX_FRAGMENT_IMAGE_UNIFORMS                   :: 44;
    MAX_COMBINED_IMAGE_UNIFORMS                   :: 45;
    MAX_GEOMETRY_TEXTURE_IMAGE_UNITS              :: 46;
    MAX_GEOMETRY_OUTPUT_VERTICES                  :: 47;
    MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS          :: 48;
    MAX_GEOMETRY_UNIFORM_COMPONENTS               :: 49;
    MAX_GEOMETRY_VARYING_COMPONENTS               :: 50;
    MAX_TESS_CONTROL_INPUT_COMPONENTS             :: 51;
    MAX_TESS_CONTROL_OUTPUT_COMPONENTS            :: 52;
    MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS          :: 53;
    MAX_TESS_CONTROL_UNIFORM_COMPONENTS           :: 54;
    MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS      :: 55;
    MAX_TESS_EVALUATION_INPUT_COMPONENTS          :: 56;
    MAX_TESS_EVALUATION_OUTPUT_COMPONENTS         :: 57;
    MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS       :: 58;
    MAX_TESS_EVALUATION_UNIFORM_COMPONENTS        :: 59;
    MAX_TESS_PATCH_COMPONENTS                     :: 60;
    MAX_PATCH_VERTICES                            :: 61;
    MAX_TESS_GEN_LEVEL                            :: 62;
    MAX_VIEWPORTS                                 :: 63;
    MAX_VERTEX_ATOMIC_COUNTERS                    :: 64;
    MAX_TESS_CONTROL_ATOMIC_COUNTERS              :: 65;
    MAX_TESS_EVALUATION_ATOMIC_COUNTERS           :: 66;
    MAX_GEOMETRY_ATOMIC_COUNTERS                  :: 67;
    MAX_FRAGMENT_ATOMIC_COUNTERS                  :: 68;
    MAX_COMBINED_ATOMIC_COUNTERS                  :: 69;
    MAX_ATOMIC_COUNTER_BINDINGS                   :: 70;
    MAX_VERTEX_ATOMIC_COUNTER_BUFFERS             :: 71;
    MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS       :: 72;
    MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS    :: 73;
    MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS           :: 74;
    MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS           :: 75;
    MAX_COMBINED_ATOMIC_COUNTER_BUFFERS           :: 76;
    MAX_ATOMIC_COUNTER_BUFFER_SIZE                :: 77;
    MAX_TRANSFORM_FEEDBACK_BUFFERS                :: 78;
    MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS :: 79;
    MAX_CULL_DISTANCES                            :: 80;
    MAX_COMBINED_CLIP_AND_CULL_DISTANCES          :: 81;
    MAX_SAMPLES                                   :: 82;
    MAX_MESH_OUTPUT_VERTICES_NV                   :: 83;
    MAX_MESH_OUTPUT_PRIMITIVES_NV                 :: 84;
    MAX_MESH_WORK_GROUP_SIZE_X_NV                 :: 85;
    MAX_MESH_WORK_GROUP_SIZE_Y_NV                 :: 86;
    MAX_MESH_WORK_GROUP_SIZE_Z_NV                 :: 87;
    MAX_TASK_WORK_GROUP_SIZE_X_NV                 :: 88;
    MAX_TASK_WORK_GROUP_SIZE_Y_NV                 :: 89;
    MAX_TASK_WORK_GROUP_SIZE_Z_NV                 :: 90;
    MAX_MESH_VIEW_COUNT_NV                        :: 91;
    MAX_MESH_OUTPUT_VERTICES_EXT                  :: 92;
    MAX_MESH_OUTPUT_PRIMITIVES_EXT                :: 93;
    MAX_MESH_WORK_GROUP_SIZE_X_EXT                :: 94;
    MAX_MESH_WORK_GROUP_SIZE_Y_EXT                :: 95;
    MAX_MESH_WORK_GROUP_SIZE_Z_EXT                :: 96;
    MAX_TASK_WORK_GROUP_SIZE_X_EXT                :: 97;
    MAX_TASK_WORK_GROUP_SIZE_Y_EXT                :: 98;
    MAX_TASK_WORK_GROUP_SIZE_Z_EXT                :: 99;
    MAX_MESH_VIEW_COUNT_EXT                       :: 100;
    MAX_DUAL_SOURCE_DRAW_BUFFERS_EXT              :: 101;
}

Uniform_Kind :: enum u32 {
    IMAGE                 :: 0;
    SAMPLER               :: 1;
    TEXTURE               :: 2;
    BUFFER                :: 3;
    STORAGE_BUFFER        :: 4;
    UNORDERED_ACCESS_VIEW :: 5;
}

Include_Type :: enum u32 {
    RELATIVE :: 0;
    STANDARD :: 1;
}

Target_Env :: enum u32 {
    SHADERC_TARGET_ENV_VULKAN;
    SHADERC_TARGET_ENV_OPENGL;
    SHADERC_TARGET_ENV_OPENGL_COMPAT;
    SHADERC_TARGET_ENV_WEBGPU;
    SHADERC_TARGET_ENV_DEFAULT :: SHADERC_TARGET_ENV_VULKAN;
}

Spirv_Version :: enum {
    _1_0 :: 0x010000;
    _1_1 :: 0x010100;
    _1_2 :: 0x010200;
    _1_3 :: 0x010300;
    _1_4 :: 0x010400;
    _1_5 :: 0x010500;
    _1_6 :: 0x010600;
}

Compilation_Status :: enum u32 {
  SUCCESS              :: 0;
  INVALID_STAGE        :: 1;
  COMPILATION_ERROR    :: 2;
  INTERNAL_ERROR       :: 3;
  NULL_RESULT_OBJECT   :: 4;
  INVALID_ASSEMBLY     :: 5;
  VALIDATION_ERROR     :: 6;
  TRANSFORMATION_ERROR :: 7;
  CONFIGURATION_ERROR  :: 8;
}

Compiler   :: struct {}
Compiler_T :: #type *Compiler;

Compile_Options   :: struct {}
Compile_Options_T :: #type *Compile_Options;

Compilation_Result   :: struct {}
Compilation_Result_T :: #type *Compilation_Result;

Include_Result :: struct {
    source_name:        *u8;
    source_name_length: u64;

    content:            *u8;
    content_length:     u64;

    user_data:          *void;
}

Include_Resolve_Proc :: #type (
    user_data:         *void,
    requested_source:  *u8,
    type:              s32,
    requesting_source: *u8,
    include_depth:     u64,
) -> *Include_Result #c_call;

Include_Result_Release_Proc :: #type (user_data: *void, include_result: *Include_Result) -> void #c_call;

compiler_initialize :: () -> Compiler_T #foreign libshaderc "shaderc_compiler_initialize";

compiler_release :: (compiler: Compiler_T) -> void #foreign libshaderc "shaderc_compiler_release";

compile_options_initialize :: () -> Compile_Options_T #foreign libshaderc "shaderc_compile_options_initialize";

compile_options_clone :: (options: Compile_Options_T) -> Compile_Options_T #foreign libshaderc "shaderc_compile_options_clone";

compile_options_release :: (options: Compile_Options_T) -> void #foreign libshaderc "shaderc_compile_options_release";

compile_options_add_macro_definition :: (
    options: Compile_Options_T,
    name:    string,
    value:   string,
) {
    shaderc_compile_options_add_macro_definition(
        options,
        name.data,
        cast(u64, name.count),
        value.data,
        cast(u64, value.count),
    );
}

compile_options_set_source_language :: (
    options: Compile_Options_T,
    lang:    Source_Language,
) -> void #foreign libshaderc "shaderc_compile_options_set_source_language";

compile_options_set_generate_debug_info :: (
    options: Compile_Options_T,
) -> void #foreign libshaderc "shaderc_compile_options_set_generate_debug_info";

compile_options_set_generate_nonsemantic_debug_info :: (
    options: Compile_Options_T,
) -> void #foreign libshaderc "shaderc_compile_options_set_generate_nonsemantic_debug_info";

compile_options_set_generate_nonsemantic_debug_source :: (
    options: Compile_Options_T,
) -> void #foreign libshaderc "shaderc_compile_options_set_generate_nonsemantic_debug_source";

compile_options_set_optimization_level :: (
    options: Compile_Options_T,
    level:   Optimization_Level,
) -> void #foreign libshaderc "shaderc_compile_options_set_optimization_level";

compile_options_set_forced_version_profile :: (
    options: Compile_Options_T,
    version: s32,
    profile: Profile,
) -> void #foreign libshaderc "shaderc_compile_options_set_forced_version_profile";

compile_options_set_include_callbacks :: (
    options:         Compile_Options_T,
    resolver:        Include_Resolve_Proc,
    result_releaser: Include_Result_Release_Proc,
    user_data:       *void,
) -> void #foreign libshaderc "shaderc_compile_options_set_include_callbacks";

compile_options_set_suppress_warnings :: (
    options: Compile_Options_T,
) -> void #foreign libshaderc "shaderc_compile_options_set_suppress_warnings";

compile_options_set_target_env :: (
    options: Compile_Options_T,
    target:  Target_Env,
    version: u32,
) -> void #foreign libshaderc "shaderc_compile_options_set_target_env";

compile_options_set_target_spirv :: (
    options: Compile_Options_T,
    version: Spirv_Version,
) -> void #foreign libshaderc "shaderc_compile_options_set_target_spirv";

compile_options_set_warnings_as_errors :: (
    options: Compile_Options_T,
) -> void #foreign libshaderc "shaderc_compile_options_set_warnings_as_errors";

compile_options_set_limit :: (
    options: Compile_Options_T,
    limit:   Limit,
    value:   s32,
) -> void #foreign libshaderc "shaderc_compile_options_set_limit";

compile_options_set_auto_bind_uniforms :: (
    options:   Compile_Options_T,
    auto_bind: bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_auto_bind_uniforms";

compile_options_set_auto_combined_image_sampler :: (
    options: Compile_Options_T,
    upgrade: bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_auto_combined_image_sampler";

compile_options_set_hlsl_io_mapping :: (
    options:    Compile_Options_T,
    hlsl_iomap: bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_io_mapping";

compile_options_set_hlsl_offsets :: (
    options: Compile_Options_T,
    hlsl_offsets: bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_offsets";

compile_options_set_binding_base :: (
    options: Compile_Options_T,
    kind:    Uniform_Kind,
    base:    u32,
) -> void #foreign libshaderc "shaderc_compile_options_set_binding_base";

compile_options_set_binding_base_for_stage :: (
    options:     Compile_Options_T,
    shader_kind: Shader_Kind,
    kind:        Uniform_Kind,
    base:        u32,
) -> void #foreign libshaderc "shaderc_compile_options_set_binding_base_for_stage";

compile_options_set_preserve_bindings :: (
    options:           Compile_Options_T,
    preserve_bindings: bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_preserve_bindings";

compile_options_set_max_id_bound :: (
    options:      Compile_Options_T,
    max_id_bound: u32,
) -> void #foreign libshaderc "shaderc_compile_options_set_max_id_bound";

compile_options_set_auto_map_locations :: (
    options:  Compile_Options_T,
    auto_map: bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_auto_map_locations";

compile_options_set_hlsl_register_set_and_binding_for_stage :: (
    options:     Compile_Options_T,
    shader_kind: Shader_Kind,
    reg:         *u8,
    set:         *u8,
    binding:     *u8,
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_register_set_and_binding_for_stage";

compile_options_set_hlsl_register_set_and_binding :: (
    options: Compile_Options_T,
    reg:     *u8,
    set:     *u8,
    binding: *u8,
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_register_set_and_binding";

compile_options_set_hlsl_functionality1 :: (
    options: Compile_Options_T,
    enable:  bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_functionality1";

compile_options_set_hlsl_16bit_types :: (
    options: Compile_Options_T,
    enable:  bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_hlsl_16bit_types";

compile_options_set_vulkan_rules_relaxed :: (
    options: Compile_Options_T,
    enable:  bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_vulkan_rules_relaxed";

compile_options_set_invert_y :: (
    options: Compile_Options_T,
    enable:  bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_invert_y";

compile_options_set_nan_clamp :: (
    options: Compile_Options_T,
    enable:  bool,
) -> void #foreign libshaderc "shaderc_compile_options_set_nan_clamp";

compile_into_spv :: (
    compiler:           Compiler_T,
    source_text:        *u8,
    source_text_size:   u64,
    shader_kind:        Shader_Kind,
    input_file_name:    *u8,
    entry_point_name:   *u8,
    additional_options: Compile_Options_T,
) -> Compilation_Result_T #foreign libshaderc "shaderc_compile_into_spv";

compile_into_spv_assembly :: (
    compiler:           Compiler_T,
    source_text:        *u8,
    source_text_size:   u64,
    shader_kind:        Shader_Kind,
    input_file_name:    *u8,
    entry_point_name:   *u8,
    additional_options: Compile_Options_T,
) -> Compilation_Result_T #foreign libshaderc "shaderc_compile_into_spv_assembly";

compile_into_preprocessed_text :: (
    compiler:           Compiler_T,
    source_text:        *u8,
    source_text_size:   u64,
    shader_kind:        Shader_Kind,
    input_file_name:    *u8,
    entry_point_name:   *u8,
    additional_options: Compile_Options_T,
) -> Compilation_Result_T #foreign libshaderc "shaderc_compile_into_preprocessed_text";

assemble_into_spv :: (
    compiler:             Compiler_T,
    source_assembly:      *u8,
    source_assembly_size: u64,
    additional_options:   Compile_Options_T,
) -> Compilation_Result_T #foreign libshaderc "shaderc_assemble_into_spv";

result_release :: (result: Compilation_Result_T) -> void #foreign libshaderc "shaderc_result_release";

result_get_length :: (result: Compilation_Result_T) -> u64 #foreign libshaderc "shaderc_result_get_length";

result_get_num_warnings :: (result: Compilation_Result_T) -> u64 #foreign libshaderc "shaderc_result_get_num_warnings";

result_get_num_errors :: (result: Compilation_Result_T) -> u64 #foreign libshaderc "shaderc_result_get_num_errors";

result_get_compilation_status :: (
    result: Compilation_Result_T,
) -> Compilation_Status #foreign libshaderc "shaderc_result_get_compilation_status";

result_get_bytes :: (result: Compilation_Result_T) -> *u8 #foreign libshaderc "shaderc_result_get_bytes";

result_get_error_message :: (result: Compilation_Result_T) -> *u8 #foreign libshaderc "shaderc_result_get_error_message";

get_spv_version :: (version: *u32, revision: *u32) -> void #foreign libshaderc "shaderc_get_spv_version";

parse_version_profile :: (str: *u8, version: *s32, profile: *Profile) -> bool #foreign libshaderc "shaderc_parse_version_profile";



#scope_file

shaderc_compile_options_add_macro_definition :: (
    options: Compile_Options_T,
    name: *u8,
    name_length: u64,
    value: *u8,
    value_length: u64,
) -> void #foreign libshaderc;

#if OS == {
    case .LINUX;
        libshaderc :: #library,no_static_library "./LINUX/libshaderc_shared";
    case;
        #assert false, "Unsupported OS";
}
