#version 460

#extension GL_EXT_nonuniform_qualifier                   : require
#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_buffer_reference                       : require

const float PI = 3.14159265359;

struct Directional_Light {
    vec3 direction;
    vec3 color;
};

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

// Normal distribution function (Trowbridge-Reitz) - D
float ndf_ggx(float alpha, vec3 N, vec3 H) {
    float alpha_squared = alpha * alpha;

    float NdotH = max(dot(N, H), 0);
    float NdotH_squared = NdotH * NdotH;

    float denominator = (NdotH_squared * (alpha_squared - 1) + 1);
    denominator = PI * denominator * denominator;

    return alpha_squared / denominator;
}

float geometry_schlick(float NdotX, float k) {
    return NdotX / (NdotX * (1 - k) + k);
}

// Smith joint masking-shadowing function - G
float geometry_smith(float roughness, vec3 N, vec3 V, vec3 L) {
    float k = pow(roughness + 1, 2) / 8;

    float NdotV = max(dot(N, V), 0);
    float NdotL = max(dot(N, L), 0);

    float G_sub1 = geometry_schlick(NdotV, k);
    float G_sub2 = geometry_schlick(NdotL, k);

    return G_sub1 * G_sub2;
}

// Fresnel-Schlick approximation - F
vec3 fresnel_schlick(vec3 F0, float HdotV) {
    float smth = pow(clamp(1.0 - HdotV, 0.0, 1.0), 5);
    return F0 + (1 - F0) * smth;
}

// Cook-Torrance specular BRDF
vec3 specular_brdf(float D, float G, vec3 F, vec3 N, vec3 V, vec3 L) {
    vec3 numerator = D * G * F;
    float denominator = 4 * max(dot(N, V), 0) * max(dot(N, L), 0) + 0.0001;

    return numerator / denominator;
}

vec3 get_normal_from_texel(vec3 vertex_normal, vec4 tangent, vec3 normal_texel, float normal_scale) {
    vec3 N = normalize(vertex_normal);
    vec3 T = normalize(tangent.xyz);
    T = normalize(T - dot(T, N) * N);
    vec3 B = cross(N, T) * tangent.w;

    vec3 normal_tangent_space = normal_texel * 2 - 1; // Range is [-1;1]
    normal_tangent_space.xy *= normal_scale;

    N = normalize(mat3(T, B, N) * normal_tangent_space);

    return N;
}

layout(push_constant, scalar) uniform Constants {
    layout(offset = 8) uint64_t material_buffer_address;
} constants;

#define ALPHA_MODE_OPAQUE 0
#define ALPHA_MODE_MASK   1
#define ALPHA_MODE_BLEND  2

layout(buffer_reference, scalar) readonly buffer Material_Buffer {
    Material materials[];
};

layout(location = 0) in Vertex_Input {
         vec4 color;
         vec3 world_space_normal;
         vec4 world_space_tangent;
         vec2 uv;
         vec3 fragment_world_position;
    flat uint material_index;
} vertex_input;

layout(set = 0, binding = 0) uniform sampler2D textures[];

layout(scalar, set = 1, binding = 0) uniform Scene_Data {
    Directional_Light directional_light;
    vec3 camera_world_position;
    vec3 ambient_color;
} scene_data;

layout(location = 0) out vec4 fragment_color;

void main() {
    Material_Buffer material_buffer = Material_Buffer(constants.material_buffer_address);
    Material material = material_buffer.materials[vertex_input.material_index];

    vec4 base_color_texel         = texture(textures[material.base_color_texture_index], vertex_input.uv);
    vec4 normal_texel             = texture(textures[material.normal_texture_index], vertex_input.uv);
    vec4 metallic_roughness_texel = texture(textures[material.metallic_roughness_texture_index], vertex_input.uv);
    vec4 occlusion_texel          = texture(textures[material.occlusion_texture_index], vertex_input.uv);
    vec4 emissive_texel           = texture(textures[material.emissive_texture_index], vertex_input.uv);

    float metallic = metallic_roughness_texel.b * material.metallic_factor;
    float occlusion = 1 + material.occlusion_strength * (occlusion_texel.r - 1);
    vec3 emissive  = material.emissive_factor * emissive_texel.rgb;
    float roughness = metallic_roughness_texel.g * material.roughness_factor;
    float roughness_clamped = max(roughness, 0.045); // 0.045 - see https://google.github.io/filament/Filament.md.html#imagingpipeline/physicallybasedcamera/bloom:~:text=1%20The%20Frostbite%20engine%20clamps%20the%20roughness%20of%20analytical%20lights%20to%200%2E045%20to%20reduce%20specular%20aliasing%2E%20This%20is%20possible%20when%20using%20single%20precision%20floats%20%28fp32%29%2E
    float roughness_squared  = roughness_clamped * roughness_clamped;

    vec4 albedo = base_color_texel * material.base_color_factor * vertex_input.color;

    // 0.04 - see https://learnopengl.com/PBR/Theory#:~:text=metals%2E-,The,notes%3A
    vec3 F0 = mix(vec3(0.04), albedo.rgb, metallic);

    vec3 N = get_normal_from_texel(
        vertex_input.world_space_normal,
        vertex_input.world_space_tangent,
        normal_texel.rgb,
        material.normal_scale
    );

    vec3 V = normalize(scene_data.camera_world_position - vertex_input.fragment_world_position);

    vec3 Lo = vec3(0);

    { // Directional light
        vec3 radiance = scene_data.directional_light.color;

        vec3 L = normalize(-scene_data.directional_light.direction);
        vec3 H = normalize(V + L);

        float D = ndf_ggx(roughness_squared, N, H);
        float G = geometry_smith(roughness_clamped, N, V, L);
        vec3 F = fresnel_schlick(F0, max(dot(H, V), 0));

        vec3 specular = specular_brdf(D, G, F, N, V, L);

        vec3  kS = F; // "Energy consevration"
        vec3  kD = (vec3(1.0) - kS) * (1.0 - metallic); // Diffuse contribution coeff (nothing for metalls)

        Lo += (kD * albedo.rgb / PI + specular) * radiance * max(dot(N, L), 0);
    }

    vec3 ambient = scene_data.ambient_color * albedo.rgb * occlusion;

    vec3 final_color = ambient + Lo;

    fragment_color = vec4(final_color, 1);
}
