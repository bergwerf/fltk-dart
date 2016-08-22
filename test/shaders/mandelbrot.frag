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
  int iter, iterations = 20;
  float tempreal, tempimag, Creal, Cimag, r2;

  vec2 rectViewport = vec2(viewport.y, viewport.y);
  vec2 pos = fract((position + rectViewport) /
    (2.0 * vec2(viewport.y, viewport.y)));

  float real = (pos.s * 3.0) - 2.0;
  float imag = (pos.t * 3.0) - 1.5;
  Creal = real;
  Cimag = imag;

  for (iter = 0; iter < iterations; iter++) {
    // z = z^2 + c
    tempreal = real;
    tempimag = imag;
    real = (tempreal * tempreal) - (tempimag * tempimag);
    imag = 2 * tempreal * tempimag;
    real += Creal;
    imag += Cimag;
    r2 = (real * real) + (imag * imag);

    if (r2 >= 4.0) {
      break;
    }
  }

  // Base the color on the number of iterations
  float value = fract(iter / float(iterations));
  vec4 color = vec4(hsv2rgb(vec3(value, 0.8, 0.8)), 1.0);

  gl_FragColor = color;
}
