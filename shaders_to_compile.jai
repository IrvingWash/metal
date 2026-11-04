SHADERS_TO_COMPILE :: Glsl_Compiler.Shader_Meta_Info.[
    {
        absolute_source_path = #run path_join(#filepath, "modules/Renderer/shaders/pbr.vertex.glsl"),
        compiled_name        = "pbr.vertex.spv",
        entry_point_name     = "main",
        kind                 = Glsl_Compiler.Shader_Kind.VERTEX_SHADER,
    },
    {
        absolute_source_path = #run path_join(#filepath, "modules/Renderer/shaders/pbr.fragment.glsl"),
        compiled_name        = "pbr.fragment.spv",
        entry_point_name     = "main",
        kind                 = Glsl_Compiler.Shader_Kind.FRAGMENT_SHADER,
    },
    {
        absolute_source_path = #run path_join(#filepath, "modules/Renderer/shaders/shadow.vertex.glsl"),
        compiled_name        = "shadow.vertex.spv",
        entry_point_name     = "main",
        kind                 = Glsl_Compiler.Shader_Kind.VERTEX_SHADER,
    },
    {
        absolute_source_path = #run path_join(#filepath, "modules/Renderer/shaders/shadow.fragment.glsl"),
        compiled_name        = "shadow.fragment.spv",
        entry_point_name     = "main",
        kind                 = Glsl_Compiler.Shader_Kind.FRAGMENT_SHADER,
    },
    {
        absolute_source_path = #run path_join(#filepath, "modules/Renderer/shaders/tonemap.vertex.glsl"),
        compiled_name        = "tonemap.vertex.spv",
        entry_point_name     = "main",
        kind                 = Glsl_Compiler.Shader_Kind.VERTEX_SHADER,
    },
    {
        absolute_source_path = #run path_join(#filepath, "modules/Renderer/shaders/tonemap.fragment.glsl"),
        compiled_name        = "tonemap.fragment.spv",
        entry_point_name     = "main",
        kind                 = Glsl_Compiler.Shader_Kind.FRAGMENT_SHADER,
    },
];

#import "String";
Glsl_Compiler :: #import "Glsl_Compiler";
