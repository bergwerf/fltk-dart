// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_FL_H
#define FLDART_FL_H

#include <FL/Fl.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
void run(Dart_NativeArguments arguments);
void scheme(Dart_NativeArguments arguments);

class _fl {
 public:
  static FunctionMapping methods[];
};
}

#endif
