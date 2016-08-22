#version 130

precision mediump float;

varying vec2 position;
uniform vec2 viewport;

void main() {
  gl_FragColor = vec4(
    position,
    viewport.x /
    viewport.y,
    1.0);
}
