// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_WIDGET_H
#define FLDART_WIDGET_H

#include <string>
#include <FL/Fl.H>
#include <FL/Fl_Widget.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Widget
class Widget {
 public:
  static void box(Dart_NativeArguments arguments);
  static void label(Dart_NativeArguments arguments);
  static void labelfont(Dart_NativeArguments arguments);
  static void labelsize(Dart_NativeArguments arguments);
  static void labeltype(Dart_NativeArguments arguments);
  static void show(Dart_NativeArguments arguments);
  static void x(Dart_NativeArguments arguments);
  static void y(Dart_NativeArguments arguments);
  static void w(Dart_NativeArguments arguments);
  static void h(Dart_NativeArguments arguments);

  // Method mapping
  static FunctionMapping methods[];
};
}

#endif
