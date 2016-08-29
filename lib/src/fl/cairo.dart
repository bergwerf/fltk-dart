// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

Uint8List _cairoGetData(cairo.ImageSurface surface, int w, int h, int d)
    native 'fldart::cairo_get_data';

/// Get pixel data from cairo.ImageSurface.
Uint8List cairoGetData(cairo.ImageSurface surface) {
  // It appears pixel data is always stored in RGBA format.
  return _cairoGetData(surface, surface.width, surface.height, 4);
}
