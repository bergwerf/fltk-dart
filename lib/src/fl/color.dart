// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Color utility function
int rgbColor(int r, [int g = -1, int b = -1]) {
  // if g and b are -1, use r as grayscale.
  if (g + b == -2) {
    return rgbColor(r, r, r);
  } else {
    return r << 24 & 0xff000000 | g << 16 & 0xff0000 | b << 8 & 0xff00;
  }
}

/// Alias for calling [rgbColor] with only one argument.
int grayscale(int l) => rgbColor(l);

/// Set application-wide background color.
void background(int r, int g, int b) native 'fldart::background';

/// Set application-wide alternative background color.
void background2(int r, int g, int b) native 'fldart::background2';

/// Set application-wide foreground color.
void foreground(int r, int g, int b) native 'fldart::foreground';

/// Set color index color value.
void setColor(int index, int r, int g, int b) native 'fldart::setColor';
