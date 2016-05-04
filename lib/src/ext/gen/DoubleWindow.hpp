// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_DOUBLE_WINDOW_H
#define FLDART_DOUBLE_WINDOW_H

#include <FL/Fl.H>
#include <FL/Fl_Double_Window.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Double_Window
class DoubleWindow {
 public:
  static void createDoubleWindowShort(Dart_NativeArguments arguments);
  static void createDoubleWindow(Dart_NativeArguments arguments);

  // Method mapping
  static FunctionMapping methods[];
};
}

#endif
