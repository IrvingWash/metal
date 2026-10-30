#version 460

#extension GL_EXT_nonuniform_qualifier : require

layout(location = 0) in Vertex_Input {
         vec4 color;
         vec3 normal;
         vec2 uv;
    flat uint base_color_texture_index;
    flat vec4 material_base_color_factor;
} vertex_input;

layout(set = 0, binding = 0) uniform sampler2D textures[];

layout(location = 0) out vec4 fragment_color;

vec3 do_light_stuff(vec3 normal, vec3 albedo);

void main() {
    vec4 texture_color = texture(textures[vertex_input.base_color_texture_index], vertex_input.uv);

    vec3 final_color = vertex_input.color.rgb * texture_color.rgb * vertex_input.material_base_color_factor.rgb;

    vec3 light_color = do_light_stuff(vertex_input.normal, final_color);
    fragment_color = vec4(light_color, texture_color.a);
}

vec3 do_light_stuff(vec3 normal, vec3 albedo) {
    vec3 n_normal = normalize(normal);

    vec3 light_color = vec3(0.5, 0.1, 0.7);
    vec3 light_direction = normalize(vec3(0, -1, -1));

    float light_alignment = max(dot(n_normal, -light_direction), 0);

    return albedo * light_alignment * light_color;
}

