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

  /// Create Fl_Widget (uses a wrapper class under the hood).
  factory Widget(int x, int y, int w, int h, [String l = '']) {
    return new Widget.fromPtr(_create(x, y, w, h, l));
  }

  /// Propagate fromPtr constructor.
  Widget.fromPtr(int ptr) : super.fromPtr(ptr);

  /// Draw
  void draw() {}

  // Getters for dimensions
  int get x => _x(ptr);
  int get y => _y(ptr);
  int get w => _w(ptr);
  int get h => _h(ptr);

  /// Show widget.
  void show() => _show(ptr);

  /// Set label.
  void label(String text) => _label(ptr, text);

  /// Set label type.
  void labelfont(int f) => _labelfont(ptr, f);

  /// Set label size.
  void labelsize(int pix) => _labelsize(ptr, pix);

  /// Set label type.
  void labeltype(Labeltype type) => _labeltype(ptr, type.index);

  /// Set boxtype.
  void box(Boxtype type) => _box(ptr, type.index);

  // Bindings with native code
  static int _create(int x, int y, int w, int h, String l)
      native 'fldart::WidgetController::createWidgetController';

  static int _x(int ptr) native 'fldart::Widget::x';
  static int _y(int ptr) native 'fldart::Widget::y';
  static int _w(int ptr) native 'fldart::Widget::w';
  static int _h(int ptr) native 'fldart::Widget::h';

  static void _show(int ptr) native 'fldart::Widget::show';
  static void _label(int ptr, String text) native 'fldart::Widget::label';
  static void _labelfont(int ptr, int f) native 'fldart::Widget::labelfont';
  static void _labelsize(int ptr, int pix) native 'fldart::Widget::labelsize';
  static void _labeltype(int ptr, int type) native 'fldart::Widget::labeltype';
  static void _box(int ptr, int type) native 'fldart::Widget::box';
}
