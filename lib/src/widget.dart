// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Widget callback function
typedef void Callback(Widget target, dynamic userData);

/// Fl_Widget
class Widget extends NativeFieldWrapperClass2 {
  /// User data
  dynamic userData;

  /// Action callback
  Callback callback;

  /// Create Fl_Widget (uses a wrapper class under the hood).
  Widget(int x, int y, int w, int h, [String l = '']) {
    _createWidget(x, y, w, h, l);
  }

  Widget.empty();

  /// Native constructor
  void _createWidget(int x, int y, int w, int h, String l)
      native 'fldart::Widget::constructor_Widget';

  /// Draw
  void draw() {}

  /// Do a callback
  void doCallback() {
    if (callback != null) {
      callback(this, userData);
    }
  }

  int get x native 'fldart::Widget::int_x';

  int get y native 'fldart::Widget::int_y';

  int get w native 'fldart::Widget::int_w';

  int get h native 'fldart::Widget::int_h';

  String get label native 'fldart::Widget::String_label';

  set label(String text) native 'fldart::Widget::void_label';

  int get labelfont native 'fldart::Widget::int_labelfont';

  set labelfont(int f) native 'fldart::Widget::void_labelfont';

  int get labelsize native 'fldart::Widget::int_labelsize';

  set labelsize(int pixels) native 'fldart::Widget::void_labelsize';

  int _labeltypeGet() native 'fldart::Widget::Fl_Labeltype_labeltype';

  void _labeltypeSet(int type) native 'fldart::Widget::void_labeltype';

  Labeltype get labeltype => Labeltype.values[_labeltypeGet()];

  set labeltype(Labeltype type) => _labeltypeSet(type.index);

  int get labelcolor native 'fldart::Widget::uint32_t_labelcolor';

  set labelcolor(int color) native 'fldart::Widget::void_labelcolor';

  int get color native 'fldart::Widget::uint32_t_color';

  /// Set widget background color.
  set color(int color) native 'fldart::Widget::void_color';

  void _boxSet(int type) native 'fldart::Widget::void_box';

  /// Set widget boxtype.
  set box(Boxtype type) => _boxSet(type.index);

  /// Show widget.
  void show() native 'fldart::Widget::void_show';

  void _image(int width, int height, int depth, Uint8List data)
      native 'fldart::Widget::void_image';

  /// Change widget image.
  set image(Image image) => _image(image.width, image.height, 4,
      new Uint8List.fromList(image.data.buffer.asUint8List()));
}
