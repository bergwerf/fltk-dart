// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Window
class Window extends Group {
  /// Public constuctor
  Window(int w, int h, [String l = '']) : super.empty() {
    ptr = _create(this, w, h, l);
  }

  Window.empty() : super.empty();

  /// Close the window.
  void hide() => _hide(ptr);

  void doCallback() {
    if (callback != null) {
      callback(this, userData);
    } else {
      // This is the default action in FLTK.
      hide();
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  // Bindings with native code
  //////////////////////////////////////////////////////////////////////////////

  static int _create(Window me, int w, int h, String l)
      native 'fldart::Window::createWindowShort';
  static void _hide(int ptr) native 'fldart::Window::void_hide';
}