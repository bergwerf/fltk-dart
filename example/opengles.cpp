// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Double_Window.H>
#include <FL/Fl_Gl_Window.H>
#include <GLES3/gl3.h>
#include <cstdio>
#include <cmath>
#include <string>

using namespace std;

class MyGlWindow : public Fl_Gl_Window {
  /// Orthograpic projection matrix
  GLfloat matrix[16] = {
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
  };

  /// Shader attributes/uniforms
  GLint aVertexPosition, uPMatrix;

  /// Scene init status
  bool init = false;

  /// Vertex buffer
  GLuint vertexBuffer;

  void draw() {
    if (!valid()) {
      // Compile shaders.
      if (!init) {
        compileShaders();
        createBuffers();
        init = true;
      }

      // Set viewport.
      glViewport(0, 0, w(), h());

      // Compute new matrix.
      // see: http://www.scratchapixel.com/lessons/3d-basic-rendering/perspective-and-orthographic-projection-matrix/orthographic-projection-matrix
      double far = 10.0;
      double near = 0.1;
      matrix[0] = 1.0 / w();
      matrix[5] = 1.0 / h();
      matrix[10] = -2.0 / (far - near);
      matrix[11] = (far + near) / (far - near);
    }

    // Clear screen.
    glClear(GL_COLOR_BUFFER_BIT);

    // Set matrix uniform.
    glUniformMatrix4fv(uPMatrix, 1, GL_FALSE, matrix);

    // Link vertex buffer.
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glVertexAttribPointer(aVertexPosition, 2, GL_FLOAT, GL_FALSE, 0, 0);
    glDrawArrays(GL_TRIANGLES, 0, 3);
  }

  static void checkShader(GLuint shader) {
    GLint is_compiled = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &is_compiled);
    if (is_compiled == GL_FALSE) {
      GLint info_log_length = 0;
      glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &info_log_length);
      GLchar *info_log = new GLchar[info_log_length];
      glGetShaderInfoLog(shader, info_log_length, &info_log_length, &info_log[0]);

      // Print info log to stdout.
      printf("%s\n", info_log);
    } else {
      printf("Shader compilation successful!\n");
    }
  }

  static void checkProgram(GLuint program) {
    GLint is_linked = 0;
    glGetProgramiv(program, GL_LINK_STATUS, &is_linked);
    if (is_linked == GL_FALSE) {
      GLint info_log_length = 0;
      glGetProgramiv(program, GL_INFO_LOG_LENGTH, &info_log_length);
      GLchar *info_log = new GLchar[info_log_length];
      glGetProgramInfoLog(program, info_log_length, &info_log_length, &info_log[0]);

      // Print info log to stdout.
      printf("%s\n", info_log);
    } else {
      printf("Program linking successful!\n");
    }
  }

  void compileShaders() {
    // Vertex shader source.
    string vs_src =
      "attribute vec2 aVertexPosition;\n"
      "uniform mat4 uPMatrix;\n"
      "varying vec2 color;\n"
      "void main(void) {\n"
      "  gl_Position = uPMatrix * vec4(aVertexPosition * 150.0, 0.0, 1.0);\n"
      "  color = aVertexPosition;\n"
      "}\n";

    // Fragment shader source.
    string fs_src =
      "precision mediump float;\n"
      "varying vec2 color;\n"
      "void main() {\n"
      "  gl_FragColor = vec4(color, 0.5, 1.0);\n"
      "}\n";

    // Compile vertex shader.
    GLuint vshader = glCreateShader(GL_VERTEX_SHADER);
    const char *vs_src_c = vs_src.c_str();
    glShaderSource(vshader, 1, &vs_src_c, NULL);
    glCompileShader(vshader);

    // Compile fragment shader.
    GLuint fshader = glCreateShader(GL_FRAGMENT_SHADER);
    const char *fs_src_c = fs_src.c_str();
    glShaderSource(fshader, 1, &fs_src_c, NULL);
    glCompileShader(fshader);

    // Attach shaders to a GLES program.
    GLuint program = glCreateProgram();
    glAttachShader(program, vshader);
    glAttachShader(program, fshader);
    glLinkProgram(program);
    glUseProgram(program);

    // Error checking.
    checkShader(vshader);
    checkShader(fshader);
    checkProgram(program);

    // Resolve attributes and uniforms.
    aVertexPosition = glGetAttribLocation(program, "aVertexPosition");
    glEnableVertexAttribArray(aVertexPosition);
    uPMatrix = glGetUniformLocation(program, "uPMatrix");
  }

  void createBuffers() {
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);

    // vertices
    GLfloat data[8] = {
      cos(M_PI / 2), sin(M_PI / 2),
      cos(M_PI / 6 * 7), sin(M_PI / 6 * 7),
      cos(M_PI / 6 * 11), sin(M_PI / 6 * 11)
    };

    glBufferData(GL_ARRAY_BUFFER, sizeof(data), data, GL_STATIC_DRAW);
  }

 public:
  MyGlWindow(int x, int y, int w, int h, const char* l = 0) : Fl_Gl_Window(x, y, w, h, l) {}
};

int main() {
  Fl_Double_Window win(200, 200, "OpenGLES");
  MyGlWindow glctx(0, 0, win.w(), win.h());
  win.end();
  win.resizable(glctx);
  win.show();
  return Fl::run();
}
