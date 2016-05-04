// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Bindings for fl_draw.H

void color(int c) native 'fldart::color';

// Line drawing
void _line1(int x, int y, int x1, int y1) native 'fldart::line';
void _line2(int x, int y, int x1, int y1, int x2, int y2) native 'fldart::line';
void line(int x, int y, int x1, int y1, [int x2 = null, int y2 = null]) {
  if (x2 != null && y2 != null) {
    _line2(x, y, x1, y1, x2, y2);
  } else {
    _line1(x, y, x1, y1);
  }
}
