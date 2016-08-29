// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Gl_Window
class GlWindow extends Window {
  /// Public constuctor
  GlWindow(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createGlWindow(x, y, w, h, l);
  }

  GlWindow.empty() : super.empty();

  /// Handle events.
  int doHandle(int event) => handle(Event.values[event]) ? 1 : 0;

  /// Native constructor
  void _createGlWindow(int x, int y, int w, int h, String l)
      native 'fldart::GlWindow::constructor_GlWindow';

  /// False if the window has been resized or if this is a new GL context.
  bool valid() native 'fldart::GlWindow::bool_valid';
}
