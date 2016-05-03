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

    // Resolve variables.
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &x);
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 1), &y);
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 2), &w);
    Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 3), &h);
    Dart_StringToCString(Dart_GetNativeArgument(arguments, 4), &l);

    instance = new Fl_Box(x, y, w, h, strcpy(new char[strlen(l) + 1], l));

    Dart_Handle result = Dart_NewInteger((int64_t)instance);
    Dart_SetReturnValue(arguments, result);
    Dart_ExitScope();
  }
}
