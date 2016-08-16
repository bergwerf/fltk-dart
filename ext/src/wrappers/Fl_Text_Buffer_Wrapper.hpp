// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_FL_TEXT_BUFFER_WRAPPER_H
#define FLDART_FL_TEXT_BUFFER_WRAPPER_H

#include <FL/Fl.H>
#include <FL/Fl_Text_Buffer.H>

#include "dart_api.h"
#include "../common.h"

namespace fldart {
class Fl_Text_Buffer_Wrapper : public Fl_Text_Buffer {
  Dart_PersistentHandle _ref;

 public:
  Fl_Text_Buffer_Wrapper(Dart_Handle ref);

  static void buffer_modified_cb(
    int pos, int nInserted, int nDeleted, int nRestyled,
    const char *deletedText, void *ptr);
};
}

#endif
