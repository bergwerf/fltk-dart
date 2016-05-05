// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_COMMON_H
#define FLDART_COMMON_H

#include <string.h>
#include "dart_api.h"

namespace fldart {
struct FunctionMapping {
  const char* name;
  Dart_NativeFunction function;
};

Dart_Handle HandleError(Dart_Handle handle);

const char* newstr(const char* src);
}

#endif
