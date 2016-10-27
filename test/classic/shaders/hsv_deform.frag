#version 130

precision mediump float;

varying vec2 position;
uniform vec2 viewport;

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 skew(float a, vec3 vec) {
  return mat3(
    1.0, tan(a), 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0) * vec;
}

void main() {
  vec2 pos = fract((position + viewport) /
    (2.0 * vec2(viewport.x, viewport.y)));

  gl_FragColor = vec4(
    hsv2rgb(vec3(
      5.0 * length(
        skew(
          sin(pos.t * 10.0),
          vec3(
            vec2(0.5, 1.0) *
            vec2(pos - vec2(0.5, 0.5)),
            0.0))),
      1.0, 0.8)),
    1.0);
}
