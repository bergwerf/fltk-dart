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
  Widget(int x, int y, int w, int h, [String l = '']) {
    ptr = _create(this, x, y, w, h, l);
  }

  Widget.empty();

  /// Draw
  void draw() {}

  /// Do a callback
  void doCallback() {
    if (callback != null) {
      callback(this, userData);
    }
  }

  // Getters for dimensions
  int get x => _x(ptr);
  int get y => _y(ptr);
  int get w => _w(ptr);
  int get h => _h(ptr);

  // Getters and setters for label properties
  String get label => _getLabel(ptr);
  set label(String text) => _setLabel(ptr, text);

  int get labelfont => _getLabelfont(ptr);
  set labelfont(int f) => _setLabelfont(ptr, f);

  int get labelsize => _getLabelsize(ptr);
  set labelsize(int pix) => _setLabelsize(ptr, pix);

  Labeltype get labeltype => Labeltype.values[_getLabeltype(ptr)];
  set labeltype(Labeltype type) => _setLabeltype(ptr, type.index);

  /// Set boxtype.
  void box(Boxtype type) => _box(ptr, type.index);

  /// Show widget.
  void show() => _show(ptr);

  //////////////////////////////////////////////////////////////////////////////
  // Bindings with native code
  //////////////////////////////////////////////////////////////////////////////

  static int _create(Widget me, int x, int y, int w, int h, String l)
      native 'fldart::Widget::createWidget';

  static int _x(int ptr) native 'fldart::Widget::int_x';
  static int _y(int ptr) native 'fldart::Widget::int_y';
  static int _w(int ptr) native 'fldart::Widget::int_w';
  static int _h(int ptr) native 'fldart::Widget::int_h';

  static String _getLabel(int ptr) native 'fldart::Widget::String_label';
  static void _setLabel(int ptr, String text)
      native 'fldart::Widget::void_label';

  static int _getLabelfont(int ptr) native 'fldart::Widget::int_labelfont';
  static void _setLabelfont(int ptr, int f)
      native 'fldart::Widget::void_labelfont';

  static int _getLabelsize(int ptr) native 'fldart::Widget::int_labelsize';
  static void _setLabelsize(int ptr, int pix)
      native 'fldart::Widget::void_labelsize';

  static int _getLabeltype(int ptr)
      native 'fldart::Widget::Fl_Labeltype_labeltype';
  static void _setLabeltype(int ptr, int type)
      native 'fldart::Widget::void_labeltype';

  static void _box(int ptr, int type) native 'fldart::Widget::void_box';
  static void _show(int ptr) native 'fldart::Widget::void_show';
}
