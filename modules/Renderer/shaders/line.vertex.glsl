#version 460

#extension GL_EXT_scalar_block_layout                    : require
#extension GL_EXT_buffer_reference                       : require
#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require

layout(push_constant, scalar, row_major) uniform Constants {
    uint64_t line_buffer_address;
    mat4x4   view_projection_transform;
} constants;

struct Line_Primitive {
    vec3 a;
    vec3 b;
    vec4 color;
};

layout(location = 0) out Vertex_Output {
         vec4 color;
} vertex_output;

layout(buffer_reference, scalar) readonly buffer Line_Buffer {
    Line_Primitive lines[];
};

void main() {
    Line_Buffer line_buffer = Line_Buffer(constants.line_buffer_address);

    Line_Primitive line = line_buffer.lines[gl_VertexIndex / 2]; // 2 vertices per line

    vec3 world_position = gl_VertexIndex % 2 == 0
        ? line.a
        : line.b;

    gl_Position = constants.view_projection_transform * vec4(world_position, 1);

    vertex_output.color = line.color;
}
