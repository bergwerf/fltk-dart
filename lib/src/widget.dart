// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Widget callback function
typedef void Callback(Widget target, dynamic userData);

/// Fl_Widget
abstract class Widget extends _Ptr {
  /// User data
  dynamic userData;

  /// Action callback
  Callback callback;

  /// Propagate fromPtr constructor.
  Widget.fromPtr(int ptr) : super.fromPtr(ptr);

  /// Show widget.
  void show() => _show(ptr);

  /// Set label.
  void label(String text) => _label(ptr, text);

  /// Set boxtype.
  void box(Boxtype type) => _box(ptr, type.index);

  // Bindings with native code
  static void _show(int ptr) native 'fldart::Widget::show';
  static void _label(int ptr, String text) native 'fldart::Widget::label';
  static void _box(int ptr, int type) native 'fldart::Widget::box';
}
