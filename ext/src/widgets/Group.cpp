// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Group.hpp"

namespace fldart {
FunctionMapping Group::methods[] = {
  {"fldart::Group::createGroup", Group::createGroup},
  {"fldart::Group::void_end", Group::void_end},
  {"fldart::Group::void_resizable", Group::void_resizable},
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
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &x));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &y));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &w));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &h));
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 4)), &l));
  instance = new Fl_Group(x,y,w,h,newstr(l));
  Dart_Handle _ret = Dart_NewInteger((int64_t)instance);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Group::void_end(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Group* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Group*)ptr;
  _ref -> end();
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Group::void_resizable(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Group* _ref;
  int64_t o;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Group*)ptr;
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &o));
  _ref -> resizable((Fl_Widget*)o);
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
