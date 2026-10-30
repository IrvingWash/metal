// CCW
static const float3 positions[3] = {
    float3( 0.0, -0.5, 0.0), // Top
    float3(-0.5,  0.5, 0.0), // Bottom Left
    float3( 0.5,  0.5, 0.0), // Bottom Right
};

static const float3 colors[3] = {
    float3(1.0, 0.0, 0.0),
    float3(0.0, 1.0, 0.0),
    float3(0.0, 0.0, 1.0),
};

struct Vertex_Result {
    float4 position : SV_Position;
    float3 color    : COLOR;
};

[shader("vertex")]
Vertex_Result vertex_main(uint vertex_id : SV_VertexID) {
    Vertex_Result output;

    output.position = float4(positions[vertex_id], 1);
    output.color    = colors[vertex_id];

    return output;
}

[shader("fragment")]
float4 fragment_main(Vertex_Result input) : SV_Target {
    return float4(input.color, 1);
}
