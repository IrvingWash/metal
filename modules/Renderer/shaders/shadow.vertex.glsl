#version 460

#extension GL_EXT_buffer_reference                       : require
#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require

layout(push_constant, scalar, row_major) uniform Constants {
    uint64_t vertex_buffer_address;
    uint64_t material_buffer_address;
    uint64_t instance_buffer_address;

    mat4x4   view_projection_transform;
} constants;

struct Vertex {
    vec3 position;
    vec4 color;
    vec3 normal;
    vec2 uv;
    vec4 tangent;
};

layout(buffer_reference, scalar) readonly buffer Vertex_Buffer {
    Vertex vertices[];
};

struct Instance {
    mat4x4 world_transform;
    mat3x3 inverse_transpose_world_transform;
    uint   material_index;
};

layout(buffer_reference, scalar, row_major) readonly buffer Instance_Buffer {
    Instance instances[];
};

layout(location = 0) out Vertex_Output {
         vec2 uv;
         vec4 color;
    flat uint material_index;
} vertex_output;


void main() {
    Vertex_Buffer   vertex_buffer   = Vertex_Buffer(constants.vertex_buffer_address);
    Instance_Buffer instance_buffer = Instance_Buffer(constants.instance_buffer_address);

    Vertex   vertex   = vertex_buffer.vertices[gl_VertexIndex];
    Instance instance = instance_buffer.instances[gl_InstanceIndex];

    gl_Position = constants.view_projection_transform * instance.world_transform * vec4(vertex.position, 1);

    vertex_output.uv             = vertex.uv;
    vertex_output.material_index = instance.material_index;
    vertex_output.color          = vertex.color;
}
