// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:math';
import 'dart:typed_data';

import 'package:dartgl/dartgl.dart';
import 'package:fltk/fltk.dart' as fl;

class MyGlWindow extends fl.GlWindow {
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
  ///
  /// Using the ratios is a hack because passing matrices to the shader is not
  /// currently working.
  int aVertexPosition, uWRatio, uHRatio;

  /// Scene init status
  bool init = false;

  /// Vertex buffer
  int vertexBuffer;

  MyGlWindow(int x, int y, int w, int h) : super(x, y, w, h);

  void draw() {
    if (!valid()) {
      // Compile shaders.
      if (!init) {
        compileShaders();
        createBuffers();
        init = true;
      }

      // Set viewport.
      glViewport(0, 0, w, h);

      // Compute new matrix.
      // see: http://www.scratchapixel.com/lessons/3d-basic-rendering/perspective-and-orthographic-projection-matrix/orthographic-projection-matrix
      double far = 10.0;
      double near = 0.1;
      matrix[0] = 1.0 / w;
      matrix[5] = 1.0 / h;
      matrix[10] = -2.0 / (far - near);
      matrix[11] = (far + near) / (far - near);
    }

    // Clear screen.
    glClear(GL_COLOR_BUFFER_BIT);

    // Set matrix uniform.
    //glUniformMatrix4fv(uPMatrix, 1, false, matrix);
    glUniform1f(uWRatio, matrix[0]);
    glUniform1f(uHRatio, matrix[5]);

    // Link vertex buffer.
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glVertexAttribPointer(aVertexPosition, 2, GL_FLOAT, false, 0, 0);
    glDrawArrays(GL_TRIANGLES, 0, 3);
  }

  static void checkShader(int shader) {
    var isCompiled = new Int32List(1);
    glGetShaderiv(shader, GL_COMPILE_STATUS, isCompiled);
    if (isCompiled[0] == GL_FALSE) {
      var infoLogLength = new Int32List(1);
      glGetShaderiv(shader, GL_INFO_LOG_LENGTH, infoLogLength);
      var infoLog = new Uint8List(infoLogLength[0]);
      glGetShaderInfoLog(shader, infoLogLength[0], infoLogLength, infoLog);

      // Print info log to stdout.
      print(new String.fromCharCodes(infoLog));
    } else {
      print("Shader compilation successful!");
    }
  }

  static void checkProgram(int program) {
    var isLinked = new Int32List(1);
    glGetProgramiv(program, GL_COMPILE_STATUS, isLinked);
    if (isLinked[0] == GL_FALSE) {
      var infoLogLength = new Int32List(1);
      glGetProgramiv(program, GL_INFO_LOG_LENGTH, infoLogLength);
      var infoLog = new Uint8List(infoLogLength[0]);
      glGetProgramInfoLog(program, infoLogLength[0], infoLogLength, infoLog);

      // Print info log to stdout.
      print(new String.fromCharCodes(infoLog));
    } else {
      print("Program linking successful!");
    }
  }

  void compileShaders() {
    // Vertex shader source.
    var vsSrc = '''
#version 100

attribute vec2 aVertexPosition;
uniform float uWRatio, uHRatio;
varying vec2 color;

void main() {
  gl_Position = mat4(
    uWRatio, 0,       0, 0,
    0,       uHRatio, 0, 0,
    0,       0,       1, 0,
    0,       0,       0, 1) * vec4(aVertexPosition * 150.0, 0.0, 1.0);
  color = aVertexPosition;
}''';

    // Fragment shader source.
    var fsSrc = '''
#version 100

varying mediump vec2 color;

void main() {
  gl_FragColor = vec4(color, 0.5, 1.0);
}''';

    // Compile vertex shader.
    int vshader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vshader, 1, [vsSrc], null);
    glCompileShader(vshader);

    // Compile fragment shader.
    int fshader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fshader, 1, [fsSrc], null);
    glCompileShader(fshader);

    // Attach shaders to a GLES program.
    int program = glCreateProgram();
    glAttachShader(program, vshader);
    glAttachShader(program, fshader);
    glLinkProgram(program);
    glUseProgram(program);

    // Error checking.
    checkShader(vshader);
    checkShader(fshader);
    checkProgram(program);

    // Resolve attributes and uniforms.
    aVertexPosition = glGetAttribLocation(program, 'aVertexPosition');
    glEnableVertexAttribArray(aVertexPosition);
    uWRatio = glGetUniformLocation(program, 'uWRatio');
    uHRatio = glGetUniformLocation(program, 'uHRatio');
  }

  void createBuffers() {
    var tmp = new Uint32List(1);
    glGenBuffers(1, tmp);
    vertexBuffer = tmp[0];
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);

    // vertices
    var data = [
      cos(PI / 2),
      sin(PI / 2),
      cos(PI / 6 * 7),
      sin(PI / 6 * 7),
      cos(PI / 6 * 11),
      sin(PI / 6 * 11)
    ];

    glBufferData(GL_ARRAY_BUFFER, data.length * 4,
        new Float32List.fromList(data), GL_STATIC_DRAW);
  }
}

int main() {
  var win = new fl.DoubleWindow(200, 200, "OpenGLES");
  var glctx = new MyGlWindow(0, 0, win.w, win.h);
  win.resizable = glctx;
  win.show();
  return fl.run();
}