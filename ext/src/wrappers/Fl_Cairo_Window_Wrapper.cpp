// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Fl_Cairo_Window_Wrapper.hpp"
#include <cstdio>

namespace fldart {
Fl_Cairo_Window_Wrapper::Fl_Cairo_Window_Wrapper(Dart_Handle ref, int w, int h, const char* l) : Fl_Cairo_Window(w, h) {
  label(l);
  _ref = Dart_NewPersistentHandle(ref);
  user_data(&_ref);
  set_draw_cb(draw_cb);
}

void Fl_Cairo_Window_Wrapper::draw_cb(Fl_Cairo_Window *self, cairo_t *ctx) {
  Dart_PersistentHandle *ref = (Dart_PersistentHandle*)self -> user_data();

  // Create instance of CairoContext.
  Dart_Handle dartCairoContextType = HandleError(Dart_GetType(
                                       Dart_LookupLibrary(
                                         Dart_NewStringFromCString("package:fltk/fltk.dart")),
                                       Dart_NewStringFromCString("CairoContext"), 0, {}));
  Dart_Handle dartCairoContext = Dart_New(
                                   dartCairoContextType, Dart_EmptyString(), 0, {});

  // Link cairo context to CairoContext.
  Dart_SetNativeInstanceField(dartCairoContext, 0, (intptr_t)ctx);

  Dart_Handle args[1] = { dartCairoContext };
  HandleError(Dart_Invoke(*ref, Dart_NewStringFromCString("runDrawCb"), 1, args));
}

int Fl_Cairo_Window_Wrapper::handle(int event) {
  Dart_Handle args[1] = { Dart_NewInteger((int64_t)event) };
  Dart_Handle ret = Dart_Invoke(_ref, Dart_NewStringFromCString("doHandle"), 1, args);
  int64_t returnValue;
  Dart_IntegerToInt64(ret, &returnValue);
  return returnValue;
}
}
