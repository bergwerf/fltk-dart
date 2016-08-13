// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl_RGB_Image.H>

#include "../gen/classes/Widget.hpp"

namespace fldart {
void Widget::void_image(Dart_NativeArguments arguments) {
  // Local variables
  int64_t ptr;
  Fl_Widget_Wrapper *_ref;
  int64_t width, height, depth;
  void **data;

  Dart_EnterScope();

  // Create pointer to FLTK object.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 0)), &ptr));
  _ref = (Fl_Widget_Wrapper*)ptr;

  // Get image dimensions.
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 1)), &width));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 2)), &height));
  HandleError(Dart_IntegerToInt64(HandleError(Dart_GetNativeArgument(arguments, 3)), &depth));

  // Get image data.
  Dart_TypedData_Type *type = new Dart_TypedData_Type(Dart_TypedData_Type::Dart_TypedData_kUint8);
  int64_t length = width * height * depth;
  Dart_Handle data_handle = HandleError(Dart_GetNativeArgument(arguments, 4));
  HandleError(Dart_TypedDataAcquireData(data_handle, type, data, &length));
  HandleError(Dart_TypedDataReleaseData(data_handle)); // !!!

  // Set image data.
  Fl_RGB_Image *image = new Fl_RGB_Image((uint8_t*)*data, width, height, depth);
  _ref -> image(image);

  // Return
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
