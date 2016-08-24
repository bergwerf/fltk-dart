// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_FL_CAIRO_WINDOW_WRAPPER_H
#define FLDART_FL_CAIRO_WINDOW_WRAPPER_H

// Force enable Cairo
#define USE_X11 1
#define FLTK_HAVE_CAIRO 1

#include <FL/Fl.H>
#include <FL/Fl_Cairo_Window.H>

#include "dart_api.h"
#include "../common.h"

namespace fldart {
class Fl_Cairo_Window_Wrapper : public Fl_Cairo_Window {
  Dart_PersistentHandle _ref;

 public:
  Fl_Cairo_Window_Wrapper(Dart_Handle ref, int w, int h, const char* l);

  static void draw_cb(Fl_Cairo_Window *self, cairo_t *ctx);
};
}

#endif
