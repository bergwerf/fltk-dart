// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_FL_TEXT_EDITOR_WRAPPER_H
#define FLDART_FL_TEXT_EDITOR_WRAPPER_H

#include <FL/Fl.H>
#include <FL/Fl_Text_Display.H>

#include <dart_api.h>

#include "../common.hpp"

namespace fldart {
class Fl_Text_Display_Wrapper : public Fl_Text_Display {
  Dart_PersistentHandle _ref;

 public:
  Fl_Text_Display_Wrapper(Dart_Handle ref, int x, int y, int w, int h, const char* l);

  // This feature is not exposed in FLTK.
  void set_scrollbar_color(Fl_Color color);
  void set_scrollbar_box(Fl_Boxtype boxtype);

  static void callback_wrapper(Fl_Widget*, void*);
};
}

#endif
