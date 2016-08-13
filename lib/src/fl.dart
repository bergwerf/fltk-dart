// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

int run() native 'fldart::run';
int scheme(String name) native 'fldart::scheme';

// Color utility function
int rgbColor(int r, [int g = -1, int b = -1]) {
  // if g and b are -1, use r as grayscale.
  if (g + b == -2) {
    return rgbColor(r, r, r);
  } else {
    return r << 24 & 0xff000000 | g << 16 & 0xff0000 | b << 8 & 0xff00;
  }
}
