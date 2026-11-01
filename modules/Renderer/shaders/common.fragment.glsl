#version 460

#extension GL_EXT_nonuniform_qualifier                   : require
#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_buffer_reference                       : require

layout(push_constant, scalar) uniform Constants {
    uint64_t vertex_buffer_address;
    uint64_t material_buffer_address;
    uint64_t instance_buffer_address;
} constants;

#define ALPHA_MODE_OPAQUE 0
#define ALPHA_MODE_MASK   1
#define ALPHA_MODE_BLEND  2

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
};

layout(buffer_reference, scalar) readonly buffer Material_Buffer {
    Material materials[];
};

layout(location = 0) in Vertex_Input {
         vec4 color;
         vec3 world_space_normal;
         vec2 uv;
         vec3 fragment_world_position;
    flat uint material_index;
} vertex_input;

layout(set = 0, binding = 0) uniform sampler2D textures[];

struct Directional_Light {
    vec3 direction;
    vec3 color;
};

layout(scalar, set = 1, binding = 0) uniform Scene_Data {
    Directional_Light directional_light;
    vec3 camera_world_position;
    vec3 ambient_color;
} scene_data;

layout(location = 0) out vec4 fragment_color;

vec3 calculate_light(vec3 world_space_normal, vec3 albedo);

void main() {
    Material_Buffer material_buffer = Material_Buffer(constants.material_buffer_address);
    Material material = material_buffer.materials[vertex_input.material_index];

    vec4 texture_color = texture(textures[material.base_color_texture_index], vertex_input.uv);

    vec3 final_color = vertex_input.color.rgb * texture_color.rgb * material.base_color_factor.rgb;

    vec3 light_color = calculate_light(vertex_input.world_space_normal, final_color);

    fragment_color = vec4(light_color, texture_color.a);
}

vec3 calculate_light(vec3 world_space_normal, vec3 albedo) {
    vec3 n_world_space_normal = normalize(world_space_normal);

    vec3 n_light_direction = normalize(scene_data.directional_light.direction);

    float light_alignment = max(dot(n_world_space_normal, -n_light_direction), 0);

    return albedo * (light_alignment * scene_data.directional_light.color + scene_data.ambient_color);
}

