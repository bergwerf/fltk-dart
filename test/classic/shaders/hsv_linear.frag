#version 130

precision mediump float;

varying vec2 position;
uniform vec2 viewport;

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
  vec2 pos = fract((position + viewport) /
    (2.0 * vec2(viewport.x, viewport.y)));

  gl_FragColor = vec4(hsv2rgb(vec3(pos.t, pos.s, 1.0)), 1.0);
}
