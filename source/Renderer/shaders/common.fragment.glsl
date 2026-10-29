#version 460

#extension GL_EXT_nonuniform_qualifier : require

layout(location = 0) in Vertex_Input {
         vec3 color;
         vec3 normal;
         vec2 uv;
    flat uint base_color_texture_index;
    flat vec4 material_base_color_factor;
} vertex_input;

layout(set = 0, binding = 0) uniform sampler2D textures[];

layout(location = 0) out vec4 fragment_color;

void main() {
    vec4 texture_color = texture(textures[vertex_input.base_color_texture_index], vertex_input.uv);

    vec3 final_color = vertex_input.color * texture_color.rgb * vertex_input.material_base_color_factor.rgb;

    fragment_color = vec4(final_color, texture_color.a);
}
