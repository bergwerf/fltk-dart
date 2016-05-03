#include <FL/Fl.H>
#include <FL/Fl_Group.H>
#include <FL/Fl_Window.H>

#include "dart_api.h"

#include "gen/Widget.h"

Dart_NativeFunction ResolveName(
  Dart_Handle name,
  int argc,
  bool* autoSetupScope);

DART_EXPORT Dart_Handle fltk_Init(Dart_Handle parentLibrary) {
  if (Dart_IsError(parentLibrary)) {
    return parentLibrary;
  }

  Dart_Handle resultCode = Dart_SetNativeResolver(
    parentLibrary, ResolveName, NULL);

  if (Dart_IsError(resultCode)) {
    return resultCode;
  }

  return Dart_Null();
}

Dart_Handle HandleError(Dart_Handle handle) {
  if (Dart_IsError(handle)) {
    Dart_PropagateError(handle);
  } else {
    return handle;
  }
}

void Fl_run(Dart_NativeArguments arguments) {
  Dart_Handle result;

  Dart_EnterScope();
  result = Dart_NewInteger(Fl::run());
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

void Fl_scheme(Dart_NativeArguments arguments) {
  Fl_Group* group;
  Dart_Handle dh_handle;

  Dart_EnterScope();

  const char* scheme;
  Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &scheme);
  Fl::scheme(scheme);

  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

void Fl_Window_create(Dart_NativeArguments arguments) {
  Fl_Window* window;
  Dart_Handle result;

  Dart_EnterScope();

  // Extract arguments.
  int64_t w, h;
  const char* l;
  Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 0), &w);
  Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 1), &h);
  Dart_StringToCString(Dart_GetNativeArgument(arguments, 2), &l);

  window = new Fl_Window(w, h, l);
  result = Dart_NewInteger((int64_t)window);
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

void Fl_Group_end(Dart_NativeArguments arguments) {
  Fl_Group* group;
  Dart_Handle dh_handle;

  Dart_EnterScope();
  dh_handle = Dart_GetNativeArgument(arguments, 0);
  int64_t ptr;
  Dart_IntegerToInt64(dh_handle, &ptr);
  group = (Fl_Group*)ptr;
  group->end();
  Dart_Handle result = Dart_Null();
  Dart_SetReturnValue(arguments, result);
  Dart_ExitScope();
}

struct FunctionLookup {
  const char* name;
  Dart_NativeFunction function;
};

FunctionLookup functionList[] = {
  {"Fl::run", Fl_run},
  {"Fl::scheme", Fl_scheme},
  {"Fl_Window::Fl_Window", Fl_Window_create},
  {"Fl_Widget::show", Widget::show},
  {"Fl_Widget::label", Widget::label},
  {"Fl_Group::end", Fl_Group_end},
  {NULL, NULL}};

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* autoSetupScope) {
  if (!Dart_IsString(name)) {
    return NULL;
  }

  Dart_NativeFunction result = NULL;
  Dart_EnterScope();
  const char* cname;
  HandleError(Dart_StringToCString(name, &cname));

  for (int i = 0; functionList[i].name != NULL; ++i) {
    if (strcmp(functionList[i].name, cname) == 0) {
      result = functionList[i].function;
      break;
    }
  }

  Dart_ExitScope();
  return result;
}
