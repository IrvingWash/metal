#ifndef TYPES_GLSL
#define TYPES_GLSL

const uint ALPHA_MODE_OPAQUE = 0;
const uint ALPHA_MODE_MASK   = 1;
const uint ALPHA_MODE_BLEND  = 2;

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

struct Directional_Light {
    vec3 direction;
    float intensity;
    vec3 color;
};

struct Vertex {
    vec3 position;
    vec4 color;
    vec3 normal;
    vec2 uv;
    vec4 tangent;
};

struct Instance {
    mat4x4 world_transform;
    mat3x3 inverse_transpose_world_transform;
    uint   material_index;
};

#endif
