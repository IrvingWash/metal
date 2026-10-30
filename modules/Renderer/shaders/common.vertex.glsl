#version 460

#extension GL_EXT_buffer_reference                       : require
#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require

layout(push_constant, scalar) uniform Constants {
    uint64_t vertex_buffer_address;
    uint64_t material_buffer_address;
    uint64_t instance_buffer_address;
} constants;

struct Vertex {
    vec3 position;
    vec4 color;
    vec3 normal;
    vec2 uv;
};

layout(buffer_reference, scalar) readonly buffer Vertex_Buffer {
    Vertex vertices[];
};

struct Material {
    vec4 base_color_factor;
    uint base_color_texture_index;
};

layout(buffer_reference, scalar) readonly buffer Material_Buffer {
    Material materials[];
};

struct Instance {
    mat4x4 wvp_transform;
    mat4x4 world_transform;
    uint   material_index;
};

layout(buffer_reference, scalar) readonly buffer Instance_Buffer {
    Instance instances[];
};

layout(location = 0) out Vertex_Output {
         vec4 color;
         vec3 normal;
         vec2 uv;
    flat uint base_color_texture_index;
    flat vec4 material_base_color_factor;
} vertex_output;

void main() {
    Vertex_Buffer   vertex_buffer   = Vertex_Buffer(constants.vertex_buffer_address);
    Instance_Buffer instance_buffer = Instance_Buffer(constants.instance_buffer_address);
    Material_Buffer material_buffer = Material_Buffer(constants.material_buffer_address);

    Vertex   vertex   = vertex_buffer.vertices[gl_VertexIndex];
    Instance instance = instance_buffer.instances[gl_InstanceIndex];
    Material material = material_buffer.materials[instance.material_index];

    gl_Position = instance.wvp_transform * vec4(vertex.position, 1);

    vertex_output.color                      = vertex.color;
    vertex_output.uv                         = vertex.uv;
    vertex_output.base_color_texture_index   = material.base_color_texture_index;
    vertex_output.material_base_color_factor = material.base_color_factor;
    vertex_output.normal                     = mat3x3(transpose(inverse(instance.world_transform))) * vertex.normal;
}
