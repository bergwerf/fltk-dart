// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <vector>

#include <FL/Fl.H>
#include <FL/Fl_Group.H>
#include <FL/Fl_Window.H>

#include "dart_api.h"
#include "common.h"

#include "gen/funcs/fl.h"
#include "gen/funcs/draw.h"

#include "gen/classes/Widget.h"
#include "gen/classes/Group.h"
#include "gen/classes/Box.h"
#include "gen/classes/Button.h"
#include "gen/classes/Input.h"
#include "gen/classes/TextEditor.h"
#include "gen/classes/TextBuffer.h"
#include "gen/classes/Window.h"
#include "gen/classes/DoubleWindow.h"
#include "gen/classes/GlWindow.h"

Dart_NativeFunction ResolveName(
  Dart_Handle name,
  int argc,
  bool *autoSetupScope);

DART_EXPORT Dart_Handle fldart_Init(Dart_Handle parentLibrary) {
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
  fldart::fl::functionMapping,
  fldart::draw::functionMapping,
  fldart::Widget::functionMapping,
  fldart::Group::functionMapping,
  fldart::Box::functionMapping,
  fldart::Button::functionMapping,
  fldart::Input::functionMapping,
  fldart::TextEditor::functionMapping,
  fldart::TextBuffer::functionMapping,
  fldart::Window::functionMapping,
  fldart::DoubleWindow::functionMapping,
  fldart::GlWindow::functionMapping
};

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool *autoSetupScope) {
  if (!Dart_IsString(name)) {
    return NULL;
  }

  Dart_NativeFunction result = NULL;
  Dart_EnterScope();
  const char *cname;
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
