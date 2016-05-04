// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_WIDGET_CONTROLLER_H
#define FLDART_WIDGET_CONTROLLER_H

#include <FL/Fl.H>
#include <FL/Fl_Widget.H>

#include "dart_api.h"
#include "common.hpp"

namespace fldart {
class WidgetController : public Fl_Widget {
 public:
  /// Constuctor
  WidgetController(int x, int y, int w, int h, const char *l);

  static void createWidgetController(Dart_NativeArguments arguments);

  void draw();

  // Method mapping
  static FunctionMapping methods[];
};
}

#endif
