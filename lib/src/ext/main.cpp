#include <vector>

#include <FL/Fl.H>
#include <FL/Fl_Group.H>
#include <FL/Fl_Window.H>

#include "dart_api.h"
#include "common.hpp"

#include "gen/Widget.hpp"
#include "gen/Group.hpp"
#include "gen/Box.hpp"
#include "gen/Window.hpp"

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

  // Initialize label types.
  fl_define_FL_SHADOW_LABEL();
  fl_define_FL_ENGRAVED_LABEL();
  fl_define_FL_EMBOSSED_LABEL();

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

fldart::FunctionMapping flFunctions[] = {
  {"fldart::run", Fl_run},
  {"fldart::scheme", Fl_scheme},
  {NULL, NULL}
};

std::vector<fldart::FunctionMapping*> allFunctions = {
  flFunctions,
  fldart::Widget::methods,
  fldart::Group::methods,
  fldart::Box::methods,
  fldart::Window::methods
};

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* autoSetupScope) {
  if (!Dart_IsString(name)) {
    return NULL;
  }

  Dart_NativeFunction result = NULL;
  Dart_EnterScope();
  const char* cname;
  HandleError(Dart_StringToCString(name, &cname));

  for (int ii = 0; ii < allFunctions.size(); ++ii) {
    for (int i = 0; allFunctions[ii][i].name != NULL; ++i) {
      if (strcmp(allFunctions[ii][i].name, cname) == 0) {
        result = allFunctions[ii][i].function;
        break;
      }
    }
  }

  Dart_ExitScope();
  return result;
}
