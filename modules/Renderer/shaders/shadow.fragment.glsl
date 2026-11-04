#version 460

#extension GL_EXT_nonuniform_qualifier                   : require
#extension GL_EXT_buffer_reference                       : require
#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require

struct Material {
    vec4 base_color_factor;
    uint base_color_texture_index;

    float metallic_factor;
    float roughness_factor;
    uint metallic_roughness_texture_index;

    float normal_scale;
    uint  normal_texture_index;

    float occlusion_strength;
    uint occlusion_texture_index;

    vec3 emissive_factor;
    uint emissive_texture_index;

    float alpha_cutoff;
    uint alpha_mode;
    uint double_sided; // 0 or 1
};

layout(buffer_reference, scalar) readonly buffer Material_Buffer {
    Material materials[];
};

layout(push_constant, scalar) uniform Constants {
    layout(offset = 8) uint64_t material_buffer_address;
} constants;

layout(set = 0, binding = 0) uniform sampler2D textures[];

layout(location = 0) in Vertex_Input {
         vec2 uv;
         vec4 color;
    flat uint material_index;
} vertex_input;

void main() {
    Material_Buffer material_buffer = Material_Buffer(constants.material_buffer_address);
    Material material = material_buffer.materials[vertex_input.material_index];

    float alpha = texture(textures[material.base_color_texture_index], vertex_input.uv).a
        * vertex_input.color.a
        * material.base_color_factor.a;

    if (alpha < material.alpha_cutoff) {
        discard;
    }
}
