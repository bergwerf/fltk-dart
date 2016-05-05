// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "common.hpp"

namespace fldart {
Dart_Handle HandleError(Dart_Handle handle) {
  if (Dart_IsError(handle)) {
    Dart_PropagateError(handle);
  } else {
    return handle;
  }
}

const char* newstr(const char* src) {
  return strcpy(new char[strlen(src) + 1], src);
}
}
