// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Box.hpp"

namespace fldart {
FunctionMapping Box::methods[] = {
  {"fldart::Box::createBox", Box::createBox},
  {NULL, NULL}
};

void Box::createBox(Dart_NativeArguments arguments) {
  Fl_Box* instance;
  int64_t x;
  int64_t y;
  int64_t w;
  int64_t h;
  const char* l;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &x));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &y));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &w));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &h));
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 4)), &l));
  instance = new Fl_Box(x,y,w,h,newstr(l));
  Dart_Handle _ret = Dart_NewInteger((int64_t)instance);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
