// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Widget.hpp"

namespace fldart {
FunctionMapping Widget::methods[] = {
  {"fldart::Widget::int_x", Widget::int_x},
  {"fldart::Widget::int_y", Widget::int_y},
  {"fldart::Widget::int_w", Widget::int_w},
  {"fldart::Widget::int_h", Widget::int_h},
  {"fldart::Widget::void_label", Widget::void_label},
  {"fldart::Widget::String_label", Widget::String_label},
  {"fldart::Widget::void_labelfont", Widget::void_labelfont},
  {"fldart::Widget::int_labelfont", Widget::int_labelfont},
  {"fldart::Widget::void_labelsize", Widget::void_labelsize},
  {"fldart::Widget::int_labelsize", Widget::int_labelsize},
  {"fldart::Widget::void_labeltype", Widget::void_labeltype},
  {"fldart::Widget::Fl_Labeltype_labeltype", Widget::Fl_Labeltype_labeltype},
  {"fldart::Widget::void_show", Widget::void_show},
  {"fldart::Widget::void_box", Widget::void_box},
  {NULL, NULL}
};

void Widget::int_x(Dart_NativeArguments arguments) {
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

void Widget::int_y(Dart_NativeArguments arguments) {
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

void Widget::int_w(Dart_NativeArguments arguments) {
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

void Widget::int_h(Dart_NativeArguments arguments) {
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

void Widget::void_label(Dart_NativeArguments arguments) {
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

void Widget::String_label(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  const char* _tmp = _ref -> label();
  Dart_Handle _ret = Dart_NewStringFromCString(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::void_labelfont(Dart_NativeArguments arguments) {
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

void Widget::int_labelfont(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = _ref -> labelfont();
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::void_labelsize(Dart_NativeArguments arguments) {
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

void Widget::int_labelsize(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = _ref -> labelsize();
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::void_labeltype(Dart_NativeArguments arguments) {
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

void Widget::Fl_Labeltype_labeltype(Dart_NativeArguments arguments) {
  int64_t ptr;
  Fl_Widget* _ref;
  Dart_EnterScope();
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget*)ptr;
  int64_t _tmp = static_cast<int64_t>(_ref -> labeltype());
  Dart_Handle _ret = Dart_NewInteger(_tmp);
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}

void Widget::void_show(Dart_NativeArguments arguments) {
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

void Widget::void_box(Dart_NativeArguments arguments) {
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
}
