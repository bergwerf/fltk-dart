// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

/// A simple text editor using FLTK and Dart, inspired by the 'Designing a
/// Simple Text Editor' tutorial from FLTK.

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
  int aVertexPosition, uPMatrix;

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
      // Set viewport.
      glViewport(0, 0, w, h);

      // Compute new matrix.
      double far = 10.0;
      double near = 0.1;
      matrix[0] = 1.0 / w;
      matrix[5] = 1.0 / h;
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

      // Link vertex buffer.
      glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
      glVertexAttribPointer(aVertexPosition, 2, GL_FLOAT, false, 0, 0);
      glDrawArrays(GL_TRIANGLES, 0, (vertexData.length / 2).floor());
    }
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
    glGetProgramiv(program, GL_LINK_STATUS, isLinked);
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
    /*// Vertex shader source.
    var vsSrc = '''
#version 100

attribute vec2 aVertexPosition;
uniform mat4 uPMatrix;
varying vec2 color;

void main() {
  gl_Position = uPMatrix * vec4(aVertexPosition * 150.0, 0.0, 1.0);
  color = aVertexPosition;
}''';

    // Fragment shader source.
    var fsSrc = '''
#version 100

varying mediump vec2 color;

void main() {
  gl_FragColor = vec4(color, 0.5, 1.0);
}''';*/

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
    checkShader(vshader);
    checkShader(fshader);
    checkProgram(program);

    // Resolve attributes and uniforms.
    aVertexPosition = glGetAttribLocation(program, 'aVertexPosition');
    glEnableVertexAttribArray(aVertexPosition);
    uPMatrix = glGetUniformLocation(program, 'uPMatrix');
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

  /// Fragment shader editor
  fl.TextEditor editor;

  /// Text buffer for the editor
  fl.TextBuffer buffer;

  /// Render output.
  Gl2DCanvas canvas;

  /// Constructor
  ShaderEditor(int w, int h, String l) : super(w, h, l) {
    color = fl.WHITE;
    var height = h;
    var half = (w / 2).round();
    var pad = 10;

    canvas = new Gl2DCanvas(0, 0, half, height);

    editor = new fl.TextEditor(half + pad, pad, w - half - pad, height - pad);
    editor.box = fl.FLAT_BOX;
    editor.cursorStyle = fl.TextDisplay.SIMPLE_CURSOR;
    editor.cursorColor = fl.rgbColor(64);
    editor.textColor = fl.rgbColor(32);
    editor.textFont = fl.COURIER;
    editor.textSize = 18;

    // Bind text buffer.
    buffer = new fl.TextBuffer();
    editor.buffer = buffer;
    buffer.text = '''
precision mediump float;

varying vec2 position;

void main() {
  gl_FragColor = vec4(
    length(position) / 200.0,
    0.5,
    0.6,
    1.0);
}
''';

    canvas.updateShaders(defaultVertexShader, buffer.text);
    canvas.updateVertexData([
      // Top-left triangle
      -half, -height, -half, height, half, height,

      // Bottom-right triangle
      half, -height, -half, -height, half, height
    ]);

    resizable = this;
    end();
  }
}

int main() {
  fl.scheme('gleam');
  var editor = new ShaderEditor(720, 480, 'Text editor');
  editor.show();
  return fl.run();
}
