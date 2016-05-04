// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "fl.hpp"

namespace fldart {
FunctionMapping _fl::methods[] = {
  {"fldart::run", run},
  {"fldart::scheme", scheme},
  {NULL, NULL}
};

void run(Dart_NativeArguments arguments) {
  // Local variables

  Dart_EnterScope();

  // Resolve variables.

  // Execute the function.
  int ret = Fl::run();

  // Resolve return value,
  Dart_Handle result = Dart_NewInteger(ret);
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}

void scheme(Dart_NativeArguments arguments) {
  // Local variables
  const char* scheme;

  Dart_EnterScope();

  // Resolve variables.
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 0)), &scheme));

  // Execute the function.
  Fl::scheme(scheme);

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}
}
