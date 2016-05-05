// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_WIDGET_H
#define FLDART_WIDGET_H

#include <FL/Fl.H>
#include <FL/Fl_Widget.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Widget
class Widget {
 public:
  static void int_x(Dart_NativeArguments arguments);
  static void int_y(Dart_NativeArguments arguments);
  static void int_w(Dart_NativeArguments arguments);
  static void int_h(Dart_NativeArguments arguments);
  static void void_label(Dart_NativeArguments arguments);
  static void String_label(Dart_NativeArguments arguments);
  static void void_labelfont(Dart_NativeArguments arguments);
  static void int_labelfont(Dart_NativeArguments arguments);
  static void void_labelsize(Dart_NativeArguments arguments);
  static void int_labelsize(Dart_NativeArguments arguments);
  static void void_labeltype(Dart_NativeArguments arguments);
  static void Fl_Labeltype_labeltype(Dart_NativeArguments arguments);
  static void void_show(Dart_NativeArguments arguments);
  static void void_box(Dart_NativeArguments arguments);
  static FunctionMapping methods[];
};
}

#endif
