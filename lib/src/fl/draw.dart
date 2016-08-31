// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Bindings for fl_draw.H

/// Set the drawing color.
set color(int c) native 'fldart::color';

/// Draw line from ([x], [y]) to ([x1], [y1]).
void _line1(int x, int y, int x1, int y1) native 'fldart::line1';

/// Draw line from ([x], [y]) to ([x1], [y1]) and then to ([x2], [y2]).
void _line2(int x, int y, int x1, int y1, int x2, int y2)
    native 'fldart::line2';

/// Draw line from ([x], [y]) to ([x1], [y1]) and optionally to ([x2], [y2]).
void line(int x, int y, int x1, int y1, [int x2 = null, int y2 = null]) {
  if (x2 != null && y2 != null) {
    _line2(x, y, x1, y1, x2, y2);
  } else {
    _line1(x, y, x1, y1);
  }
}

/// Draw image data using `fl_draw_image`.
void drawImage(Uint8List buffer, int x, int y, int w, int h,
    [int d = 3, int l = 0]) native 'fldart::draw_image';

/// Draw image data using Fl_RGB_Image and fallback alpha blending driver.
void drawRgbImage(Uint8List buffer, int x, int y, int w, int h,
    [int d = 3, int l = 0]) native 'fldart::rgb_image_draw';
