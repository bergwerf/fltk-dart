// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Window
class Window {
  /// Integer to store the pointer address.
  final int _ptr;

  /// Public constuctor
  factory Window(int w, int h, [String l = '']) {
    return new Window._internal(_create(w, h, l));
  }

  /// Internal constuctor
  Window._internal(this._ptr);

  /// End window group
  void end() => _end(_ptr);

  /// Show window
  void show() => _show(_ptr);

  /// Bindings with native code
  static int _create(int w, int h, String l) native 'Fl_Window::Fl_Window';
  static void _end(int ptr) native 'Fl_Group::end';
  static void _show(int ptr) native 'Fl_Widget::show';
}
