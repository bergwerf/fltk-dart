// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#ifndef FLDART_CUSTOM_H
#define FLDART_CUSTOM_H

#include <cstdlib>

#include <cairo.h>

#include <FL/Fl_RGB_Image.H>

#include <dart_api.h>

#include "common.hpp"

namespace fldart {
namespace custom {
void cairo_get_data(Dart_NativeArguments arguments);
void draw_image_using_driver(Dart_NativeArguments arguments);

static FunctionMapping functionMapping[] = {
  {"fldart::cairo_get_data", cairo_get_data},
  {"fldart::draw_image_using_driver", draw_image_using_driver},
  {NULL, NULL}
};
}
}

#endif
