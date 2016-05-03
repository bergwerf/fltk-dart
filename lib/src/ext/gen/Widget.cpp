#include "Widget.hpp"

namespace fldart {
  FunctionMapping Widget::methods[] = {
    {"fldart::Widget::box", Widget::box},
    {"fldart::Widget::label", Widget::label},
    {"fldart::Widget::labelfont", Widget::labelfont},
    {"fldart::Widget::labelsize", Widget::labelsize},
    {"fldart::Widget::labeltype", Widget::labeltype},
    {"fldart::Widget::show", Widget::show},
    {NULL, NULL}
  };

  void Widget::box(Dart_NativeArguments arguments) {
    // Local variables
    int64_t ptr;
    Fl_Widget* ref;
    int64_t type;

    Dart_EnterScope();

    // Resolve reference.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
    ref = (Fl_Widget*)ptr;

    // Resolve other variables.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 1), &type);

    // Execute this method.
    ref -> box(static_cast<Fl_Boxtype>(type));

    // Resolve return value,
    Dart_Handle result = Dart_Null();
    Dart_SetReturnValue(arguments, result);

    Dart_ExitScope();
  }

  void Widget::label(Dart_NativeArguments arguments) {
    // Local variables
    int64_t ptr;
    Fl_Widget* ref;
    const char* text;

    Dart_EnterScope();

    // Resolve reference.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
    ref = (Fl_Widget*)ptr;

    // Resolve other variables.
    Dart_StringToCString(Dart_GetNativeArgument(arguments, 1), &text);

    // Execute this method.
    ref -> label(strcpy(new char[strlen(text) + 1], text));

    // Resolve return value,
    Dart_Handle result = Dart_Null();
    Dart_SetReturnValue(arguments, result);

    Dart_ExitScope();
  }

  void Widget::labelfont(Dart_NativeArguments arguments) {
    // Local variables
    int64_t ptr;
    Fl_Widget* ref;
    int64_t f;

    Dart_EnterScope();

    // Resolve reference.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
    ref = (Fl_Widget*)ptr;

    // Resolve other variables.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 1), &f);

    // Execute this method.
    ref -> labelfont(f);

    // Resolve return value,
    Dart_Handle result = Dart_Null();
    Dart_SetReturnValue(arguments, result);

    Dart_ExitScope();
  }

  void Widget::labelsize(Dart_NativeArguments arguments) {
    // Local variables
    int64_t ptr;
    Fl_Widget* ref;
    int64_t pix;

    Dart_EnterScope();

    // Resolve reference.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
    ref = (Fl_Widget*)ptr;

    // Resolve other variables.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 1), &pix);

    // Execute this method.
    ref -> labelsize(pix);

    // Resolve return value,
    Dart_Handle result = Dart_Null();
    Dart_SetReturnValue(arguments, result);

    Dart_ExitScope();
  }

  void Widget::labeltype(Dart_NativeArguments arguments) {
    // Local variables
    int64_t ptr;
    Fl_Widget* ref;
    int64_t type;

    Dart_EnterScope();

    // Resolve reference.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &ptr);
    ref = (Fl_Widget*)ptr;

    // Resolve other variables.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 1), &type);

    // Execute this method.
    ref -> labeltype(static_cast<Fl_Labeltype>(type));

    // Resolve return value,
    Dart_Handle result = Dart_Null();
    Dart_SetReturnValue(arguments, result);

    Dart_ExitScope();
  }

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
    ref -> show();

    // Resolve return value,
    Dart_Handle result = Dart_Null();
    Dart_SetReturnValue(arguments, result);

    Dart_ExitScope();
  }
}
