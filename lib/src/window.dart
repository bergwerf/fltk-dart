// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Window
class Window extends Group {
  /// Create window with the given dimensions
  Window(int w, int h, [String l = '']) : super.empty() {
    _createWindow(w, h, l);
  }

  /// Create window with the given dimensions at the given position.
  Window.at(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createWindowAt(x, y, w, h, l);
  }

  Window.empty() : super.empty();

  /// Handle events.
  int doHandle(int event) => handle(Event.values[event]) ? 1 : 0;

  /// Short native constructor
  void _createWindow(int w, int h, String l)
      native 'fldart::Window::constructor_WindowShort';

  /// Native constructor
  void _createWindowAt(int x, int y, int w, int h, String l)
      native 'fldart::Window::constructor_Window';

  void doCallback() {
    if (callback != null) {
      callback(this, userData);
    } else {
      // This is the default action in FLTK.
      hide();
    }
  }
}
