#include "Widget.h"

void Widget::show(Dart_NativeArguments arguments) {
  // Local variables
  int64_t ptr;
  Fl_Widget* ref;

  Dart_EnterScope();

  // Resolve reference.
  Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
  ref = (Fl_Widget*)ptr;

  // Resolve other variables.

  // Execute this method.
  ref->show();

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}

void Widget::label(Dart_NativeArguments arguments) {
  // Local variables
  int64_t ptr;
  Fl_Widget* ref;
  const char* str;

  Dart_EnterScope();

  // Resolve reference.
  Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
  ref = (Fl_Widget*)ptr;

  // Resolve other variables.
  Dart_StringToCString(Dart_GetNativeArgument(arguments, 1), &str);

  // Execute this method.
  ref->label(str);

  // Resolve return value,
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);

  Dart_ExitScope();
}
