#version 460

// CCW
const vec3 positions[3] = vec3[](
    vec3( 0.0, -0.5, 0.0), // Top
    vec3(-0.5,  0.5, 0.0), // Bottom Left
    vec3( 0.5,  0.5, 0.0)  // Bottom Right
);

const vec3 colors[3] = vec3[](
    vec3(1.0, 0.0, 0.0),
    vec3(0.0, 1.0, 0.0),
    vec3(0.0, 0.0, 1.0)
);

layout (location = 0) out vec3 output_color;

void main() {
    gl_Position = vec4(positions[gl_VertexIndex], 1);

    output_color = colors[gl_VertexIndex];
}
