// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_WINDOW_H
#define FLDART_WINDOW_H

#include <FL/Fl.H>
#include <FL/Fl_Window.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Window
class Window {
 public:
  static void createWindowShort(Dart_NativeArguments arguments);
  static void createWindow(Dart_NativeArguments arguments);
  static FunctionMapping methods[];
};
}

#endif
