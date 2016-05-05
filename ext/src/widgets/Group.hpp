// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_GROUP_H
#define FLDART_GROUP_H

#include <FL/Fl.H>
#include <FL/Fl_Group.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
/// Dart bindings for Fl_Group
class Group {
 public:
  static void createGroup(Dart_NativeArguments arguments);
  static void void_end(Dart_NativeArguments arguments);
  static void void_resizable(Dart_NativeArguments arguments);
  static FunctionMapping methods[];
};
}

#endif
