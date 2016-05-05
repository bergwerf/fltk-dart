// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_BUTTON_H
#define FLDART_BUTTON_H

#include <FL/Fl.H>
#include <FL/Fl_Button.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Button
class Button {
 public:
  static void createButton(Dart_NativeArguments arguments);
  static FunctionMapping methods[];
};
}

#endif
