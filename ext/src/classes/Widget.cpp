// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl_RGB_Image.H>

#include "../gen/classes/Widget.hpp"

namespace fldart {
void Widget::void_image(Dart_NativeArguments arguments) {
  // Local variables
  Fl_Widget_Wrapper *_ref;
  int64_t width, height, depth;

  Dart_EnterScope();

  // Create pointer to FLTK object.
  _ref = (Fl_Widget_Wrapper*)getptr(arguments, 0);

  // Get image dimensions.
  HandleError(Dart_IntegerToInt64(getarg(arguments, 1), &width));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 2), &height));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 3), &depth));

  // Get image data.
  uint8_t *data = getUint8List(arguments, 4);

  // Set image data.
  auto image = new Fl_RGB_Image(data, width, height, depth);
  _ref -> image(image);

  // Return
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
