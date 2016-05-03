// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Widget callback function
typedef void Callback(Widget target, dynamic userData);

/// Fl_Widget
class Widget extends _Ptr {
  /// User data
  dynamic userData;

  /// Action callback
  Callback callback;

  /// Public constuctor
  factory Widget(int x, int y, int w, int h, [String l = '']) {
    return new Widget.fromPtr(_create(x, y, w, h, l));
  }

  /// Internal constuctor
  Widget.fromPtr(int ptr) : super.fromPtr(ptr);

  /// Show widget.
  void show() => _show(ptr);

  /// Set label.
  void label(String label) => _label(ptr, label);

  /// Bindings with native code
  static int _create(int x, int y, int w, int h, String l)
      native 'Fl_Widget::Fl_Widget';
  static void _show(int ptr) native 'Fl_Widget::show';
  static void _label(int ptr, String label) native 'Fl_Widget::label';
}
