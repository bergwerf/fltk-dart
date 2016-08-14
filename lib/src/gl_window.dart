// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Gl_Window
class GlWindow extends Window {
  /// Public constuctor
  GlWindow(int x, int y, int w, int h, [String l = '']) : super.empty() {
    ptr = _create(this, x, y, w, h, l);
  }

  GlWindow.empty() : super.empty();

  bool valid() => _getValid(ptr);
  //void valid(bool v) => _setValid(ptr, v);

  //////////////////////////////////////////////////////////////////////////////
  // Bindings with native code
  //////////////////////////////////////////////////////////////////////////////

  static int _create(GlWindow me, int x, int y, int w, int h, String l)
      native 'fldart::GlWindow::createGlWindow';

  static bool _getValid(int ptr) native 'fldart::GlWindow::bool_valid';
  //static bool _setValid(int ptr, bool v) native 'fldart::GlWindow::void_valid';
}
