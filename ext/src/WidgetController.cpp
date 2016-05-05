// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "WidgetController.hpp"

namespace fldart {
FunctionMapping WidgetController::methods[] = {
  {"fldart::WidgetController::createWidgetController", WidgetController::createWidgetController},
  {NULL, NULL}
};

WidgetController::WidgetController(Dart_Handle ref, int x, int y, int w, int h, const char *l=0) : Fl_Widget(x, y, w, h, l) {
  dartref = Dart_NewPersistentHandle(ref);
}

void WidgetController::createWidgetController(Dart_NativeArguments arguments) {
  WidgetController* instance;
  Dart_Handle ref;
  int64_t x;
  int64_t y;
  int64_t w;
  int64_t h;
  const char* l;

  Dart_EnterScope();

  // Resolve variables.
  ref = HandleError(Dart_GetNativeArgument(arguments, 0));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &x));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &y));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &w));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 4)), &h));
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 5)), &l));

  instance = new WidgetController(ref, x, y, w, h, strcpy(new char[strlen(l) + 1], l));

  Dart_Handle result = Dart_NewInteger((int64_t)instance);
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

void WidgetController::draw() {
  Dart_Invoke(dartref, Dart_NewStringFromCString("draw"), 0, {});
}
}
