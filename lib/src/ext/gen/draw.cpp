// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "draw.hpp"

namespace fldart {
FunctionMapping _draw::methods[] = {
  {"fldart::color", color},
  {"fldart::line1", line1},
  {"fldart::line2", line2},
  {NULL, NULL}
};

void color(Dart_NativeArguments arguments) {
  // Local variables
  int64_t c;

  Dart_EnterScope();

  // Resolve variables.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &c));

  // Execute the function.
  fl_color((Fl_Color)c);

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}

void line1(Dart_NativeArguments arguments) {
  // Local variables
  int64_t x;
  int64_t y;
  int64_t x1;
  int64_t y1;

  Dart_EnterScope();

  // Resolve variables.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &x));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &y));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &x1));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &y1));

  // Execute the function.
  fl_line(x, y, x1, y1);

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}

void line2(Dart_NativeArguments arguments) {
  // Local variables
  int64_t x;
  int64_t y;
  int64_t x1;
  int64_t y1;
  int64_t x2;
  int64_t y2;

  Dart_EnterScope();

  // Resolve variables.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &x));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &y));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &x1));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &y1));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 4)), &x2));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 5)), &y2));

  // Execute the function.
  fl_line(x, y, x1, y1, x2, y2);

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}
}
