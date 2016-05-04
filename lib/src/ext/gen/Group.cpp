// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Group.hpp"

namespace fldart {
FunctionMapping Group::methods[] = {
  {"fldart::Group::createGroup", Group::createGroup},
  {"fldart::Group::end", Group::end},
  {"fldart::Group::resizable", Group::resizable},
  {NULL, NULL}
};

void Group::createGroup(Dart_NativeArguments arguments) {
  Fl_Group* instance;
  int64_t x;
  int64_t y;
  int64_t w;
  int64_t h;
  const char* l;

  Dart_EnterScope();

  // Resolve variables.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &x));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &y));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &w));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &h));
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 4)), &l));

  instance = new Fl_Group(x, y, w, h, strcpy(new char[strlen(l) + 1], l));

  Dart_Handle result = Dart_NewInteger((int64_t)instance);
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

void Group::end(Dart_NativeArguments arguments) {
  // Local variables
  int64_t ptr;
  Fl_Group* ref;

  Dart_EnterScope();

  // Resolve reference.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  ref = (Fl_Group*)ptr;

  // Resolve other variables.

  // Execute this method.
  ref -> end();

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}

void Group::resizable(Dart_NativeArguments arguments) {
  // Local variables
  int64_t ptr;
  Fl_Group* ref;
  int64_t o;

  Dart_EnterScope();

  // Resolve reference.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  ref = (Fl_Group*)ptr;

  // Resolve other variables.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &o));

  // Execute this method.
  ref -> resizable((Fl_Widget*)o);

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}
}
