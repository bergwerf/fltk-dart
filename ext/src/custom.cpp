// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "custom.hpp"
#include <cstdio>

namespace fldart {
namespace custom {

// Types from cairodart
typedef void(*DestroyFunc)(void*);
struct _BindInfo {
  void* handle;
  DestroyFunc destroy_func;
};

void cairo_get_data(Dart_NativeArguments arguments) {
  Dart_EnterScope();

  // Resolve cairo_surface_t from cairodart library.
  _BindInfo *info = (_BindInfo*)getptr(arguments, 0);
  cairo_surface_t *surface = (cairo_surface_t*)info -> handle;
  int64_t w, h, d;

  // Read width, height, depth arguments
  HandleError(Dart_IntegerToInt64(getarg(arguments, 1), &w));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 2), &h));
  HandleError(Dart_IntegerToInt64(getarg(arguments, 3), &d));

  // Get surface data.
  intptr_t length = w * h * d;
  unsigned char *data = cairo_image_surface_get_data(surface);

  // Create Uint8List with surface data.
  Dart_Handle list = Dart_NewTypedData(Dart_TypedData_Type::Dart_TypedData_kUint8, length);
  Dart_ListSetAsBytes(list, 0, data, length);

  Dart_SetReturnValue(arguments, list);
  Dart_ExitScope();
}

void draw_image_using_driver(Dart_NativeArguments arguments) {
  uint8_t* buffer;
  int64_t x, y, w, h, d, ld;

  Dart_EnterScope();

  // Not so pretty, but copied from generated output.
  buffer = (uint8_t*)*gettypeddata(arguments, 0, Dart_TypedData_Type::Dart_TypedData_kUint8);

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
