// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "custom.hpp"
#include <cstdio>

namespace fldart {
namespace custom {
void rgb_image_draw(Dart_NativeArguments arguments) {
  Dart_EnterScope();

  uint8_t* buffer = getUint8List(arguments, 0);

  int64_t x, y, w, h, d, ld;
  HandleError(Dart_IntegerToInt64(getarg(arguments, 1), &x));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 2), &y));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 3), &w));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 4), &h));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 5), &d));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 6), &ld));

  auto img = new Fl_RGB_Image(buffer, w, h, d, ld);
  img -> draw(x, y);
  delete img;

  Dart_SetReturnValue(arguments, Dart_Null());
  Dart_ExitScope();
}
}
}
