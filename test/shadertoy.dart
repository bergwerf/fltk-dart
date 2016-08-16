// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

/// A simple text editor using FLTK and Dart, inspired by the 'Designing a
/// Simple Text Editor' tutorial from FLTK.

import 'dart:async';
import 'dart:typed_data';

import 'package:dartgl/dartgl.dart';
import 'package:fltk/fltk.dart' as fl;

/// More generic 2D GL canvas based on opengl.dart
class Gl2DCanvas extends fl.GlWindow {
  /// Orthograpic projection matrix
  final Float32List matrix = new Float32List.fromList([
    //
    1.0, 0.0, 0.0, 0.0,
    //
    0.0, 1.0, 0.0, 0.0,
    //
    0.0, 0.0, 1.0, 0.0,
    //
    0.0, 0.0, 0.0, 1.0
  ]);

  /// Shader attributes/uniforms
  int aVertexPosition, uPMatrix, uViewportWidth, uViewportHeight;

  /// Scene init status
  bool init = false;

  /// Vertex buffer
  int vertexBuffer;

  /// Vertex and fragment shader code.
  String vertexShader, fragmentShader;

  /// Vertex buffer data.
  List<num> vertexData;

  /// Shader and buffer update state.
  int shaderState = 0, bufferState = 0;

  Gl2DCanvas(int x, int y, int w, int h) : super(x, y, w, h);

  void updateShaders(String _vertexShader, String _fragmentShader) {
    vertexShader = _vertexShader;
    fragmentShader = _fragmentShader;
    shaderState = 1;
  }

  void updateVertexData(List<num> data) {
    vertexData = data;
    bufferState = 1;
  }

  void draw() {
    if (!valid()) {
      final width = w;
      final height = h;

      // Set viewport.
      glViewport(0, 0, width, height);

      // Update vertices.
      updateVertexData([
        // Top-left triangle
        -width, -height, -width, height, width, height,

        // Bottom-right triangle
        width, -height, -width, -height, width, height
      ]);

      // Compute new matrix.
      double far = 10.0;
      double near = 0.1;
      matrix[0] = 1.0 / width;
      matrix[5] = 1.0 / height;
      matrix[10] = -2.0 / (far - near);
      matrix[11] = (far + near) / (far - near);
    }

    if (shaderState == 1) {
      compileShaders();
      shaderState = 2;
    }

    if (bufferState == 1) {
      updateBuffer(vertexData);
      bufferState = 2;
    }

    // Clear screen.
    glClear(GL_COLOR_BUFFER_BIT);

    if (shaderState != 0 && bufferState != 0) {
      // Set matrix uniform.
      glUniformMatrix4fv(uPMatrix, 1, false, matrix);

      // Set viewport uniforms.
      glUniform1f(uViewportWidth, w.toDouble());
      glUniform1f(uViewportHeight, h.toDouble());

      // Link vertex buffer.
      glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
      glVertexAttribPointer(aVertexPosition, 2, GL_FLOAT, false, 0, 0);
      glDrawArrays(GL_TRIANGLES, 0, (vertexData.length / 2).floor());
    }
  }

  static bool checkShader(int shader) {
    var isCompiled = new Int32List(1);
    glGetShaderiv(shader, GL_COMPILE_STATUS, isCompiled);
    if (isCompiled[0] == GL_FALSE) {
      var infoLogLength = new Int32List(1);
      glGetShaderiv(shader, GL_INFO_LOG_LENGTH, infoLogLength);
      var infoLog = new Uint8List(infoLogLength[0]);
      glGetShaderInfoLog(shader, infoLogLength[0], infoLogLength, infoLog);

      // Print info log to stdout.
      print(new String.fromCharCodes(infoLog));
      return false;
    } else {
      print("Shader compilation successful!");
      return true;
    }
  }

  static bool checkProgram(int program) {
    var isLinked = new Int32List(1);
    glGetProgramiv(program, GL_LINK_STATUS, isLinked);
    if (isLinked[0] == GL_FALSE) {
      var infoLogLength = new Int32List(1);
      glGetProgramiv(program, GL_INFO_LOG_LENGTH, infoLogLength);
      var infoLog = new Uint8List(infoLogLength[0]);
      glGetProgramInfoLog(program, infoLogLength[0], infoLogLength, infoLog);

      // Print info log to stdout.
      print(new String.fromCharCodes(infoLog));
      return false;
    } else {
      print("Program linking successful!");
      return true;
    }
  }

  void compileShaders() {
    // Compile vertex shader.
    int vshader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vshader, 1, [vertexShader], null);
    glCompileShader(vshader);

    // Compile fragment shader.
    int fshader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fshader, 1, [fragmentShader], null);
    glCompileShader(fshader);

    // Attach shaders to a GLES program.
    int program = glCreateProgram();
    glAttachShader(program, vshader);
    glAttachShader(program, fshader);
    glLinkProgram(program);
    glUseProgram(program);

    // Error checking.
    if (checkShader(vshader) && checkShader(fshader) && checkProgram(program)) {
      // Resolve attributes and uniforms.
      aVertexPosition = glGetAttribLocation(program, 'aVertexPosition');
      glEnableVertexAttribArray(aVertexPosition);
      uPMatrix = glGetUniformLocation(program, 'uPMatrix');
      uViewportWidth = glGetUniformLocation(program, 'viewportWidth');
      uViewportHeight = glGetUniformLocation(program, 'viewportHeight');
    }
  }

  void updateBuffer(List<num> data) {
    var tmp = new Uint32List(1);
    glGenBuffers(1, tmp);
    vertexBuffer = tmp[0];
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(
        GL_ARRAY_BUFFER,
        data.length * 4,
        new Float32List.fromList(new List<double>.generate(
            data.length, (int i) => data[i].toDouble())),
        GL_STATIC_DRAW);
  }
}

/// The fragment shader code editor.
class ShaderEditor extends fl.DoubleWindow {
  /// Default vertex shader
  static const defaultVertexShader = '''
attribute vec2 aVertexPosition;
uniform mat4 uPMatrix;
varying vec2 position;

void main(void) {
  gl_Position = uPMatrix * vec4(aVertexPosition, 0.0, 1.0);
  position = aVertexPosition;
}
''';

  /// Last compiled shader.
  String lastShader = '';

  /// Fragment shader editor
  fl.TextEditor editor;

  /// Recompile button.
  fl.Button button;

  /// Text buffer for the editor
  fl.TextBuffer buffer;

  /// Render output.
  Gl2DCanvas canvas;

  /// Constructor
  ShaderEditor(int _w, int _h, String l) : super(_w, _h, l) {
    color = fl.WHITE;
    final width = _w;
    final height = _h;
    final half = (_w / 2).round();

    // Create canvas.
    canvas = new Gl2DCanvas(0, 0, half, height);

    // Create button.
    button = new fl.Button(half, 0, width - half, 40, 'Recompile!');
    button.box = fl.FLAT_BOX;
    button.color = fl.WHITE;
    button.labelsize = 20;
    button.onCallback.listen((_) => update());

    // Create editor.
    editor = new fl.TextEditor(half, button.h, width - half, height - button.h);
    editor.box = fl.FLAT_BOX;
    editor.cursorStyle = fl.TextDisplay.SIMPLE_CURSOR;
    editor.cursorColor = fl.rgbColor(64);
    editor.textColor = fl.rgbColor(32);
    editor.textFont = fl.COURIER;
    editor.textSize = 18;
    editor.linenumberWidth = 60;
    editor.linenumberSize = 18;
    editor.linenumberFormat = '%d ';
    editor.linenumberFont = fl.COURIER_BOLD;
    editor.linenumberBgColor = fl.WHITE;

    // Setup buffer.
    buffer = new fl.TextBuffer();
    buffer.onModify.listen((data) {
      if (data.nInserted > 0 || data.nDeleted > 0) {
        if (buffer.text == lastShader) {
          button.labelfont = fl.COURIER;
          button.labelcolor = fl.BLACK;
          button.label = 'Recompile';
        } else {
          button.labelfont = fl.COURIER_BOLD_ITALIC;
          button.labelcolor = fl.DARK_GREEN;
          button.label = 'Recompile!';
        }

        button.redraw();
      }
    });

    // Bind text buffer to editor and load cool mandelbrot shader.
    editor.buffer = buffer;
    buffer.text = mandelbrotShader;

    resizable = new fl.Widget(0, button.h, width, height - button.h);
    end();

    // Update shaders.
    update();
  }

  void update() {
    button.labelfont = fl.COURIER;
    button.labelcolor = fl.BLACK;
    button.label = 'Recompile';
    button.redraw();

    lastShader = buffer.text;
    canvas.updateShaders(defaultVertexShader, lastShader);
    canvas.redraw();
  }
}

Future main() {
  fl.scheme('gtk+');
  var editor = new ShaderEditor(720, 480, 'Shadertoy');
  editor.show();
  return fl.runAsync();
}

/// Mandelbrot shader
const mandelbrotShader = '''
precision mediump float;

varying vec2 position;
uniform float viewportWidth, viewportHeight;

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
  int iter, iterations = 20;
  float tempreal, tempimag, Creal, Cimag, r2;

  vec2 viewport = vec2(viewportHeight, viewportHeight);
  vec2 pos = fract((position + viewport) /
    (2.0 * vec2(viewportHeight, viewportHeight)));

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
  float value = fract(iter / (float)iterations);
  vec4 color = vec4(hsv2rgb(vec3(value, 0.8, 0.8)), 1.0);

  gl_FragColor = color;
}
''';

/// HSV color gradient shader.
const hsvGradientShader = '''
precision mediump float;

varying vec2 position;
uniform float viewportWidth, viewportHeight;

vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
  vec2 viewport = vec2(viewportWidth, viewportHeight);
  vec2 pos = fract((position + viewport) /
    (2.0 * vec2(viewportWidth, viewportHeight)));

  gl_FragColor = vec4(hsv2rgb(vec3(pos.t, pos.s, 1.0)), 1.0);
}
''';

/// Deformed HSV radial gradient shader
const hsvRadialGradientShader = '''
varying vec2 position;
uniform float viewportWidth, viewportHeight;

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
  vec2 viewport = vec2(viewportWidth, viewportHeight);
  vec2 pos = fract((position + viewport) /
    (2.0 * vec2(viewportWidth, viewportHeight)));

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
''';
