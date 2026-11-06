#version 460

layout(location = 0) in Vertex_Input {
         vec4 color;
} vertex_input;

layout(location = 0) out vec4 fragment_color;

void main() {
    fragment_color = vertex_input.color;
}
