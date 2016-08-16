// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "Fl_Text_Buffer_Wrapper.hpp"

namespace fldart {
Fl_Text_Buffer_Wrapper::Fl_Text_Buffer_Wrapper(Dart_Handle ref) : Fl_Text_Buffer() {
  _ref = Dart_NewPersistentHandle(ref);
  add_modify_callback(buffer_modified_cb, &_ref);

}

void Fl_Text_Buffer_Wrapper::buffer_modified_cb(
  int pos, int nInserted, int nDeleted, int nRestyled,
  const char *deletedText, void *ptr) {

  Dart_PersistentHandle *ref = (Dart_PersistentHandle*)ptr;
  Dart_Handle args[5] = {
    Dart_NewInteger((int64_t)pos),
    Dart_NewInteger((int64_t)nInserted),
    Dart_NewInteger((int64_t)nDeleted),
    Dart_NewInteger((int64_t)nRestyled),
    deletedText == NULL ? Dart_EmptyString() : Dart_NewStringFromCString(deletedText)
  };
  Dart_Invoke(*ref, Dart_NewStringFromCString("bufferModified"), 5, args);
}
}
