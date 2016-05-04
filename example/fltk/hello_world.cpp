// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Box.H>

int main(int argc, char **argv) {
  Fl::scheme("gleam");
  Fl_Window *window = new Fl_Window(300, 180, "FLTK");
  Fl_Box *box = new Fl_Box(20, 40, 260, 100, "Hello, World!");
  box -> box(FL_UP_BOX);
  box -> labelsize(36);
  box -> labelfont(FL_BOLD + FL_ITALIC);
  box -> labeltype(FL_SHADOW_LABEL);
  window -> end();
  window -> show(argc, argv);
  return Fl::run();
}
