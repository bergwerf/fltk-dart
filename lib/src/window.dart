// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Window
class Window extends Group {
  /// Public constuctor
  Window(int w, int h, [String l = '']) : super.empty() {
    _createWindow(w, h, l);
  }

  Window.empty() : super.empty();

  /// Native constructor
  void _createWindow(int w, int h, String l)
      native 'fldart::Window::constructor_WindowShort';

  /// Close the window.
  void hide() native 'fldart::Window::void_hide';

  void doCallback() {
    if (callback != null) {
      callback(this, userData);
    } else {
      // This is the default action in FLTK.
      hide();
    }
  }
}
