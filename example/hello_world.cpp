// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Box.H>

int main(int argc, char **argv) {
  Fl::scheme("gleam");
  auto window = new Fl_Window(350, 180, "FLTK");
  auto box = new Fl_Box(20, 40, 310, 100, "Hello, World!");
  box -> box(FL_UP_BOX);
  box -> labelsize(36);
  box -> labelfont(FL_BOLD + FL_ITALIC);
  box -> labeltype(FL_SHADOW_LABEL);
  box -> labelcolor(FL_YELLOW);
  box -> color(FL_RED);
  window -> end();
  window -> show(argc, argv);
  return Fl::run();
}
