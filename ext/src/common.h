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

/// Catch exceptions in a Dart_Handle
Dart_Handle HandleError(Dart_Handle handle);

/// Create a copy of the given string.
const char* newstr(const char *src);

/// Dart API helpers.
Dart_Handle getarg(Dart_NativeArguments arguments, int n);
Dart_Handle getfield(Dart_Handle container, const char *name);
intptr_t getptr(Dart_NativeArguments arguments, int argn);
}

#endif
