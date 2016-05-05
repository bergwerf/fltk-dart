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
  Dart_EnterScope();
  int64_t _tmp = Fl::run();
  Dart_Handle result = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

void scheme(Dart_NativeArguments arguments) {
  const char* scheme;
  Dart_EnterScope();
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 0)), &scheme));
  Fl::scheme(newstr(scheme));
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}
}
