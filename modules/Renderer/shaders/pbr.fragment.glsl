#version 460

#extension GL_EXT_nonuniform_qualifier                   : require
#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require
#extension GL_EXT_buffer_reference                       : require

#include "types.glsl"

const float PI = 3.14159265359;

const uint ALPHA_MODE_OPAQUE = 0;
const uint ALPHA_MODE_MASK   = 1;
const uint ALPHA_MODE_BLEND  = 2;

const uint MAX_DIRECTIONAL_LIGHT_COUNT = 1;
const uint MAX_SPOT_LIGHT_COUNT = 16;
const uint MAX_SHADOWED_SPOT_LIGHT_COUNT = 16;

const uint FALLBACK_NORMAL_TEXTURE_ID = 1;

float calculate_shadow(
    sampler2DShadow shadow_map,
    vec3 fragment_world_position,
    mat4x4 light_view_projection_transform,
    vec3 world_space_normal,
    vec2 shadow_map_size,
    float texel_world_size
) {
    // Fix offset for double sided materials
    vec3 geometric_normal = normalize(world_space_normal);
    if (!gl_FrontFacing) {
        geometric_normal = -geometric_normal;
    }

    // Normal offset
    vec3 offset_position = fragment_world_position + geometric_normal * texel_world_size * 1.5;

    vec4 light_space_position = light_view_projection_transform * vec4(offset_position, 1.0);
    vec3 ndc_position = light_space_position.xyz / light_space_position.w;

    if (ndc_position.z < 0.0 || ndc_position.z > 1.0) {
        return 0.0; // Beyond far plane
    }

    // Shadow pass viewport is y-flipped, so flipping here
    vec2 uv = vec2(ndc_position.x * 0.5 + 0.5, 0.5 - ndc_position.y * 0.5);

    // PCF
    vec2 texel = 1.0 / shadow_map_size;
    float lit = 0.0;
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            lit += texture(shadow_map, vec3(uv + vec2(x, y) * texel, ndc_position.z));
        }
    }
    lit /= 9.0;

    return 1.0 - lit;
}

// Normal distribution function (Trowbridge-Reitz) - D
float ndf_ggx(float alpha, vec3 N, vec3 H) {
    float alpha_squared = alpha * alpha;

    float NdotH = max(dot(N, H), 0.0);
    float NdotH_squared = NdotH * NdotH;

    float denominator = (NdotH_squared * (alpha_squared - 1.0) + 1.0);
    denominator = PI * denominator * denominator;

    return alpha_squared / denominator;
}

float geometry_schlick(float NdotX, float k) {
    return NdotX / (NdotX * (1.0 - k) + k);
}

// Smith joint masking-shadowing function - G
float geometry_smith(float roughness, vec3 N, vec3 V, vec3 L) {
    float k = pow(roughness + 1.0, 2.0) / 8.0;

    float NdotV = max(dot(N, V), 0.0);
    float NdotL = max(dot(N, L), 0.0);

    float G_sub1 = geometry_schlick(NdotV, k);
    float G_sub2 = geometry_schlick(NdotL, k);

    return G_sub1 * G_sub2;
}

// Fresnel-Schlick approximation - F
vec3 fresnel_schlick(vec3 F0, float HdotV) {
    float smth = pow(clamp(1.0 - HdotV, 0.0, 1.0), 5.0);
    return F0 + (1.0 - F0) * smth;
}

// Cook-Torrance specular BRDF
vec3 specular_brdf(float D, float G, vec3 F, vec3 N, vec3 V, vec3 L) {
    vec3 numerator = D * G * F;
    float denominator = 4.0 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0) + 0.0001;

    return numerator / denominator;
}

vec3 get_normal_from_texel(vec3 world_space_vertex_normal, vec4 vertex_tangent, vec3 normal_texel, float normal_scale) {
    vec3 N = normalize(world_space_vertex_normal);
    vec3 T = normalize(vertex_tangent.xyz);
    T = normalize(T - dot(T, N) * N);
    vec3 B = cross(N, T) * vertex_tangent.w;

    vec3 normal_tangent_space = normal_texel * 2.0 - 1.0; // Range is [-1;1]
    normal_tangent_space.xy *= normal_scale;

    N = normalize(mat3(T, B, N) * normal_tangent_space);

    return N;
}

vec3 do_light(
    vec3 V,
    vec3 L,
    vec3 N,
    vec3 F0,
    vec3 radiance,
    vec3 albedo,
    float roughness_squared,
    float roughness_clamped,
    float metallic
) {
    vec3 H = normalize(V + L);

    float D = ndf_ggx(roughness_squared, N, H);
    float G = geometry_smith(roughness_clamped, N, V, L);
    vec3 F = fresnel_schlick(F0, max(dot(H, V), 0.0));

    vec3 specular = specular_brdf(D, G, F, N, V, L);

    vec3  kS = F; // "Energy consevration"
    vec3  kD = (vec3(1.0) - kS) * (1.0 - metallic); // Diffuse contribution coeff (nothing for metalls)

    return (kD * albedo.rgb / PI + specular) * radiance * max(dot(N, L), 0.0);
}

layout(constant_id = 0) const uint ALPHA_MODE = 0;
layout(constant_id = 1) const uint DISCARD_BLEND_SINGLE_SIDED_BACK_FACES = 0; // 0 or 1

layout(push_constant, scalar) uniform Constants {
    layout(offset = 8) uint64_t material_buffer_address;
} constants;

layout(buffer_reference, scalar) readonly buffer Material_Buffer {
    Material materials[];
};

layout(set = 0, binding = 0) uniform sampler2D textures[];

layout(scalar, set = 1, binding = 0, row_major) uniform Scene_Data {
    Directional_Light directional_lights[MAX_DIRECTIONAL_LIGHT_COUNT];
    uint directional_light_count;
    vec3 camera_world_position;
    vec3 ambient_color;

    Spot_Light spot_lights[MAX_SPOT_LIGHT_COUNT];
    uint spot_light_count;

    Shadowed_Spot_Light shadowed_spot_lights[MAX_SHADOWED_SPOT_LIGHT_COUNT];
    uint shadowed_spot_light_count;
} scene_data;

layout(set = 2, binding = 0) uniform sampler2DShadow directional_shadow_maps[MAX_DIRECTIONAL_LIGHT_COUNT];
layout(set = 2, binding = 1) uniform sampler2DShadow spot_shadow_maps[MAX_SHADOWED_SPOT_LIGHT_COUNT];

layout(location = 0) in Vertex_Input {
         vec4 color;
    flat vec4 tint;
         vec3 world_space_normal;
         vec4 world_space_tangent;
         vec2 uv;
         vec3 fragment_world_position;
    flat uint material_index;
} vertex_input;

layout(location = 0) out vec4 fragment_color;

void main() {
    Material_Buffer material_buffer = Material_Buffer(constants.material_buffer_address);
    Material material = material_buffer.materials[vertex_input.material_index];

    if (DISCARD_BLEND_SINGLE_SIDED_BACK_FACES == 1 && material.double_sided == 0 && !gl_FrontFacing) {
        discard;
    }

    vec4 base_color_texel         = texture(textures[material.base_color_texture_index], vertex_input.uv);
    vec4 metallic_roughness_texel = texture(textures[material.metallic_roughness_texture_index], vertex_input.uv);
    vec4 occlusion_texel          = texture(textures[material.occlusion_texture_index], vertex_input.uv);
    vec4 emissive_texel           = texture(textures[material.emissive_texture_index], vertex_input.uv);

    vec4 albedo = base_color_texel
        * material.base_color_factor
        * vertex_input.color
        * vertex_input.tint;

    if (ALPHA_MODE == ALPHA_MODE_MASK && albedo.a < material.alpha_cutoff) {
        discard;
    }

    float metallic = metallic_roughness_texel.b * material.metallic_factor;
    float occlusion = 1 + material.occlusion_strength * (occlusion_texel.r - 1);
    vec3 emissive  = material.emissive_factor * emissive_texel.rgb;
    float roughness = metallic_roughness_texel.g * material.roughness_factor;
    float roughness_clamped = max(roughness, 0.045); // 0.045 - see https://google.github.io/filament/Filament.md.html#imagingpipeline/physicallybasedcamera/bloom:~:text=1%20The%20Frostbite%20engine%20clamps%20the%20roughness%20of%20analytical%20lights%20to%200%2E045%20to%20reduce%20specular%20aliasing%2E%20This%20is%20possible%20when%20using%20single%20precision%20floats%20%28fp32%29%2E
    float roughness_squared  = roughness_clamped * roughness_clamped;

    // 0.04 - see https://learnopengl.com/PBR/Theory#:~:text=metals%2E-,The,notes%3A
    vec3 F0 = mix(vec3(0.04), albedo.rgb, metallic);

    vec3 N;
    if (material.normal_texture_index == FALLBACK_NORMAL_TEXTURE_ID) {
        N = normalize(vertex_input.world_space_normal);
    } else {
        vec4 normal_texel = texture(textures[material.normal_texture_index], vertex_input.uv);

        N = get_normal_from_texel(
            vertex_input.world_space_normal,
            vertex_input.world_space_tangent,
            normal_texel.rgb,
            material.normal_scale
        );
    }
    if (!gl_FrontFacing) {
        N = -N;
    }

    vec3 V = normalize(scene_data.camera_world_position - vertex_input.fragment_world_position);

    vec3 Lo = vec3(0);
    // Directional lights
    for (uint i = 0; i < min(scene_data.directional_light_count, MAX_DIRECTIONAL_LIGHT_COUNT); i++) {
        Directional_Light directional_light = scene_data.directional_lights[i];

        vec3 radiance = directional_light.color * directional_light.intensity;
        vec3 L = normalize(-directional_light.direction);

        vec3 light = do_light(
            V, L, N, F0,
            radiance,
            albedo.rgb,
            roughness_squared,
            roughness_clamped,
            metallic
        );

        vec2 shadow_map_size = vec2(textureSize(directional_shadow_maps[i], 0));
        float texel_world_size = (2.0 * directional_light.radius) / shadow_map_size.x;
        float shadow = calculate_shadow(
            directional_shadow_maps[i],
            vertex_input.fragment_world_position,
            directional_light.view_projection_transform,
            vertex_input.world_space_normal,
            shadow_map_size,
            texel_world_size
        );

        Lo += (1 - shadow) * light;
    }
    // Spot lights
    for (uint i = 0; i < min(scene_data.spot_light_count, MAX_SPOT_LIGHT_COUNT); i++) {
        Spot_Light spot_light = scene_data.spot_lights[i];

        vec3 vector_to_light = spot_light.position - vertex_input.fragment_world_position;
        float distance_to_light = length(vector_to_light);
        if (distance_to_light >= spot_light.range) {
            continue;
        }

        vec3 L = vector_to_light / distance_to_light;

        float attenuation = max(
            min(
                1.0 - pow(distance_to_light / spot_light.range, 4.0),
                1.0
            ),
            0.0
        ) / max(pow(distance_to_light, 2.0), 0.0001);

        // https://github.com/KhronosGroup/glTF/blob/main/extensions/2.0/Khronos/KHR_lights_punctual/README.md
        float angular_attenuation = 0.0;
        {
            // @Todo: move this to CPU
            float light_angle_scale = 1.0 / max(0.001, spot_light.inner_cutoff_half_angle_cos - spot_light.outer_cutoff_half_angle_cos);
            float light_angle_offset = -spot_light.outer_cutoff_half_angle_cos * light_angle_scale;

            float cd = dot(normalize(spot_light.direction), -L); // In the reference the light direction is inversed
            angular_attenuation = clamp(cd * light_angle_scale + light_angle_offset, 0.0, 1.0);
            angular_attenuation *= angular_attenuation;
        }
        if (angular_attenuation == 0.0) {
            continue;
        }

        vec3 radiance = spot_light.color * spot_light.intensity * angular_attenuation * attenuation;

        Lo += do_light(
            V, L, N, F0,
            radiance,
            albedo.xyz,
            roughness_squared,
            roughness_clamped,
            metallic
        );
    }

    // Shadowed spot lights
    for (uint i = 0; i < min(scene_data.shadowed_spot_light_count, MAX_SHADOWED_SPOT_LIGHT_COUNT); i++) {
        Shadowed_Spot_Light shadowed_spot_light = scene_data.shadowed_spot_lights[i];

        vec3 vector_to_light = shadowed_spot_light.position - vertex_input.fragment_world_position;
        float distance_to_light = length(vector_to_light);
        if (distance_to_light >= shadowed_spot_light.range) {
            continue;
        }

        vec3 L = vector_to_light / distance_to_light;

        float attenuation = max(
            min(
                1.0 - pow(distance_to_light / shadowed_spot_light.range, 4.0),
                1.0
            ),
            0.0
        ) / max(pow(distance_to_light, 2.0), 0.0001);

        // https://github.com/KhronosGroup/glTF/blob/main/extensions/2.0/Khronos/KHR_lights_punctual/README.md
        float angular_attenuation = 0.0;
        {
            // @Todo: move this to CPU
            float light_angle_scale = 1.0 / max(
                0.001,
                shadowed_spot_light.inner_cutoff_half_angle_cos - shadowed_spot_light.outer_cutoff_half_angle_cos
            );
            float light_angle_offset = -shadowed_spot_light.outer_cutoff_half_angle_cos * light_angle_scale;

            float cd = dot(normalize(shadowed_spot_light.direction), -L); // In the reference the light direction is inversed
            angular_attenuation = clamp(cd * light_angle_scale + light_angle_offset, 0.0, 1.0);
            angular_attenuation *= angular_attenuation;
        }
        if (angular_attenuation == 0.0) {
            continue;
        }

        vec3 radiance = shadowed_spot_light.color * shadowed_spot_light.intensity * angular_attenuation * attenuation;

        float tan_half_fov = sqrt(1 - shadowed_spot_light.outer_cutoff_half_angle_cos * shadowed_spot_light.outer_cutoff_half_angle_cos)
            / shadowed_spot_light.outer_cutoff_half_angle_cos;
        vec2 shadow_map_size = vec2(textureSize(spot_shadow_maps[i], 0));
        float texel_world_size = 2.0 * distance_to_light * tan_half_fov / shadow_map_size.x;
        float shadow = calculate_shadow(
            spot_shadow_maps[i],
            vertex_input.fragment_world_position,
            shadowed_spot_light.view_projection_transform,
            vertex_input.world_space_normal,
            shadow_map_size,
            texel_world_size
        );

        vec3 light = do_light(
            V, L, N, F0,
            radiance,
            albedo.xyz,
            roughness_squared,
            roughness_clamped,
            metallic
        );

        Lo += (1 -shadow) * light;
    }

    vec3 ambient = scene_data.ambient_color * albedo.rgb * occlusion;

    vec3 final_color = ambient + Lo + emissive;

    fragment_color = vec4(
        final_color,
        ALPHA_MODE == ALPHA_MODE_BLEND ? albedo.a : 1.0
    );
}
