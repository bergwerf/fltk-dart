// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Double_Window.H>
#include <FL/Fl_Gl_Window.H>
#include <GL/gl.h>
#include <stdio.h>

class MyGlWindow : public Fl_Gl_Window {
  void draw() {
    if (!valid()) {
      // Set viewport.
      glViewport(0, 0, w(), h());

      // Set view matrix.
      glLoadIdentity();
      glOrtho(-w(), w(), -h(), h(), -1, 1);

      // Init nice line drawing.
      glEnable(GL_LINE_SMOOTH);
      glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    }

    // Clear screen.
    glClear(GL_COLOR_BUFFER_BIT);

    // Draw white 'X'
    glLineWidth(0.9);
    glColor3f(1.0, 1.0, 1.0);
    glBegin(GL_LINE_STRIP);
    glVertex2f(w(), h());
    glVertex2f(-w(), -h());
    glEnd();
    glBegin(GL_LINE_STRIP);
    glVertex2f(w(), -h());
    glVertex2f(-w(), h());
    glEnd();
  }

 public:
  MyGlWindow(int x, int y, int w, int h, const char* l = 0) : Fl_Gl_Window(x, y, w, h, l) {}
};

int main() {
  auto window = new Fl_Double_Window(200, 200, "OpenGL X");
  auto mygl = new MyGlWindow(0, 0, window -> w(), window -> h());
  window -> end();
  window -> resizable(mygl);
  window -> show();
  return Fl::run();
}
