#version 460

#extension GL_EXT_scalar_block_layout : require

#include "vendor/pbrNeutral.glsl"

layout(push_constant, scalar) uniform Constants {
    float exposure;
} constants;

layout(set = 0, binding = 0) uniform sampler2D hdr_texture;

layout(location = 0) out vec4 fragment_color;

void main() {
    vec4 texel = texelFetch(hdr_texture, ivec2(gl_FragCoord.xy), 0).rgba;

    fragment_color = vec4(PBRNeutralToneMapping(texel.rgb * constants.exposure), texel.a);
}
