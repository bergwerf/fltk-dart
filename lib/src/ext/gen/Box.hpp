// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_BOX_H
#define FLDART_BOX_H

#include <FL/Fl.H>
#include <FL/Fl_Box.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Box
class Box {
 public:
  static void createBox(Dart_NativeArguments arguments);

  // Method mapping
  static FunctionMapping methods[];
};
}

#endif
