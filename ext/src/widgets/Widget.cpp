// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Widget.hpp"

namespace fldart {
FunctionMapping Widget::methods[] = {
  {"fldart::Widget::x", Widget::x},
  {"fldart::Widget::y", Widget::y},
  {"fldart::Widget::w", Widget::w},
  {"fldart::Widget::h", Widget::h},
  {"fldart::Widget::show", Widget::show},
  {"fldart::Widget::box", Widget::box},
  {"fldart::Widget::label", Widget::label},
  {"fldart::Widget::labelfont", Widget::labelfont},
  {"fldart::Widget::labelsize", Widget::labelsize},
  {"fldart::Widget::labeltype", Widget::labeltype},
  {NULL, NULL}
};

void Widget::x(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = _ref -> x();
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::y(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = _ref -> y();
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::w(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = _ref -> w();
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::h(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = _ref -> h();
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::show(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  _ref -> show();
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::box(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  int64_t type;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &type));
  _ref -> box(static_cast<Fl_Boxtype>(type));
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::label(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  const char* text;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  HandleError(Dart_StringToCString(HandleError(Dart_GetNativeArgument(arguments, 1)), &text));
  _ref -> label(newstr(text));
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::labelfont(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  int64_t f;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &f));
  _ref -> labelfont(f);
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::labelsize(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  int64_t pix;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &pix));
  _ref -> labelsize(pix);
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::labeltype(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  int64_t type;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &type));
  _ref -> labeltype(static_cast<Fl_Labeltype>(type));
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
