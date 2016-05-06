// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Input
class Input extends Widget {
  /// Public constuctor
  Input(int x, int y, int w, int h, [String l = '']) : super.empty() {
    ptr = _create(this, x, y, w, h, l);
  }

  Input.empty() : super.empty();

  //////////////////////////////////////////////////////////////////////////////
  // Bindings with native code
  //////////////////////////////////////////////////////////////////////////////

  static int _create(Input me, int x, int y, int w, int h, String l)
      native 'fldart::Input::createInput';
}
