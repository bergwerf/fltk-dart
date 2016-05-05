// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_DRAW_H
#define FLDART_DRAW_H

#include <FL/Fl.H>
#include <FL/fl_draw.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
void color(Dart_NativeArguments arguments);
void line1(Dart_NativeArguments arguments);
void line2(Dart_NativeArguments arguments);

class _draw {
 public:
  static FunctionMapping methods[];
};
}

#endif
