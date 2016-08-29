// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Box
class Box extends Widget {
  /// Public constuctor
  Box(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createBox(x, y, w, h, l);
  }

  Box.empty() : super.empty();

  /// Native constructor
  void _createBox(int x, int y, int w, int h, String l)
      native 'fldart::Box::constructor_Box';
}
