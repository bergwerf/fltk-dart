// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Double_Window.H>
#include <FL/Fl_Text_Editor.H>
#include <FL/Fl_Text_Buffer.H>

int main(int argc, char **argv) {
  auto window = new Fl_Double_Window(120, 20, "");
  auto editor = new Fl_Text_Editor(0, 0, window -> w(), window -> h());
  editor -> box(FL_FLAT_BOX);
  editor -> deactivate();

  auto buffer = new Fl_Text_Buffer();
  buffer -> text("red, green, blue");
  editor -> buffer(buffer);

  Fl_Text_Display::Style_Table_Entry styletable[] = {     // Style table
    { FL_BLACK,      FL_HELVETICA,      FL_NORMAL_SIZE }, // A - Default
    { FL_RED,        FL_COURIER,        FL_NORMAL_SIZE }, // B - Red
    { FL_DARK_GREEN, FL_COURIER_ITALIC, FL_NORMAL_SIZE }, // C - Green
    { FL_BLUE,       FL_COURIER_BOLD,   FL_NORMAL_SIZE }, // D - Blue
  };
  auto highlightBuffer = new Fl_Text_Buffer();
  highlightBuffer -> text("BBBAACCCCCAADDDD");
  editor -> highlight_data(highlightBuffer, styletable, 4, 0, 0, 0);

  window -> end();
  window -> show(argc, argv);
  return Fl::run();
}
