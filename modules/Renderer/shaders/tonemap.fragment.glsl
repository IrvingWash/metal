#version 460

#extension GL_EXT_scalar_block_layout : require

// https://github.com/KhronosGroup/ToneMapping/blob/main/PBR_Neutral/pbrNeutral.glsl
vec3 PBRNeutralToneMapping(vec3 color) {
  const float startCompression = 0.8 - 0.04;
  const float desaturation = 0.15;

  float x = min(color.r, min(color.g, color.b));
  float offset = x < 0.08 ? x - 6.25 * x * x : 0.04;
  color -= offset;

  float peak = max(color.r, max(color.g, color.b));
  if (peak < startCompression) return color;

  const float d = 1. - startCompression;
  float newPeak = 1. - d * d / (peak + d - startCompression);
  color *= newPeak / peak;

  float g = 1. - 1. / (desaturation * (peak - newPeak) + 1.);
  return mix(color, newPeak * vec3(1, 1, 1), g);
}

layout(push_constant, scalar) uniform Constants {
    float exposure;
} constants;

layout(set = 0, binding = 0) uniform sampler2D hdr_texture;

layout(location = 0) out vec4 fragment_color;

void main() {
    vec4 texel = texelFetch(hdr_texture, ivec2(gl_FragCoord.xy), 0).rgba;

    fragment_color = vec4(PBRNeutralToneMapping(texel.rgb * constants.exposure), texel.a);
}
