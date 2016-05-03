// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Window
class Window extends Widget {
  /// Public constuctor
  factory Window(int w, int h, [String l = '']) {
    return new Window.fromPtr(_create(w, h, l));
  }

  /// Internal constuctor
  Window.fromPtr(int ptr) : super.fromPtr(ptr);

  /// End window group
  void end() => _end(ptr);

  /// Bindings with native code
  static int _create(int w, int h, String l) native 'Fl_Window::Fl_Window';
  static void _end(int ptr) native 'Fl_Group::end';
}
