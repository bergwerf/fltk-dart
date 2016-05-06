// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <vector>

#include <FL/Fl.H>
#include <FL/Fl_Group.H>
#include <FL/Fl_Window.H>

#include "dart_api.h"
#include "common.hpp"

#include "gen/core/fl.hpp"
#include "gen/core/draw.hpp"

#include "gen/classes/Widget.hpp"
#include "gen/classes/Group.hpp"
#include "gen/classes/Box.hpp"
#include "gen/classes/Button.hpp"
#include "gen/classes/Input.hpp"
#include "gen/classes/TextEditor.hpp"
#include "gen/classes/TextBuffer.hpp"
#include "gen/classes/Window.hpp"
#include "gen/classes/DoubleWindow.hpp"

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

std::vector<fldart::FunctionMapping*> allFunctions = {
  fldart::_fl::methods,
  fldart::_draw::methods,

  fldart::Widget::methods,
  fldart::Group::methods,
  fldart::Box::methods,
  fldart::Button::methods,
  fldart::Input::methods,
  fldart::TextEditor::methods,
  fldart::TextBuffer::methods,
  fldart::Window::methods,
  fldart::DoubleWindow::methods
};

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* autoSetupScope) {
  if (!Dart_IsString(name)) {
    return NULL;
  }

  Dart_NativeFunction result = NULL;
  Dart_EnterScope();
  const char* cname;
  fldart::HandleError(Dart_StringToCString(name, &cname));

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
