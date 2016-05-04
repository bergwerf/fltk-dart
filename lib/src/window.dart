// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Window
class Window extends Group {
  /// Public constuctor
  Window(int w, int h, [String l = '']) : super.empty() {
    ptr = _create(w, h, l);
  }

  Window.empty() : super.empty();

  // Bindings with native code
  static int _create(int w, int h, String l)
      native 'fldart::Window::createWindowShort';
}
