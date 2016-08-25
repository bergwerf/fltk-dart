// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Fl_Text_Editor_Wrapper.hpp"

namespace fldart {
Fl_Text_Editor_Wrapper::Fl_Text_Editor_Wrapper(Dart_Handle ref, int x, int y, int w, int h, const char* l) : Fl_Text_Editor(x, y, w, h, l) {
  _ref = Dart_NewPersistentHandle(ref);
  callback(callback_wrapper, &_ref);
}

void Fl_Text_Editor_Wrapper::set_scrollbar_color(Fl_Color color) {
  mHScrollBar -> color(color);
  mVScrollBar -> color(color);
}

void Fl_Text_Editor_Wrapper::set_scrollbar_box(Fl_Boxtype boxtype) {
  mHScrollBar -> slider(boxtype);
  mVScrollBar -> slider(boxtype);
}

void Fl_Text_Editor_Wrapper::callback_wrapper(Fl_Widget*, void *ptr) {
  Dart_PersistentHandle *ref = (Dart_PersistentHandle*)ptr;
  HandleError(Dart_Invoke(*ref, Dart_NewStringFromCString("doCallback"), 0, {}));
}
}
