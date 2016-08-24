// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Wrapper around [NativeFieldWrapperClass2] to carry the
class CairoContext extends NativeFieldWrapperClass2 {}

/// Cairo draw callback
typedef void CairoDrawCb(CairoWindow window, cairodart.Context ctx);

/// Fl_Cairo_Window
class CairoWindow extends DoubleWindow {
  /// FLTK style Cairo callback
  CairoDrawCb _drawCallback;

  /// Public constuctor
  CairoWindow(int w, int h, [String l = '']) : super.empty() {
    _createCairoWindow(w, h, l);
  }

  CairoWindow.empty() : super.empty();

  /// Set draw callback.
  set drawCallback(CairoDrawCb cb) => _drawCallback = cb;

  /// Internal draw callback
  /// Do not override this method!
  void runDrawCb(CairoContext cairo) {
    var ctx = new cairodart.Context.fromNative(cairo);
    onDraw(ctx);
  }

  /// Draw callback.
  void onDraw(cairodart.Context ctx) {
    if (_drawCallback != null) {
      _drawCallback(this, ctx);
    }
  }

  /// Native constructor
  void _createCairoWindow(int w, int h, String l)
      native 'fldart::CairoWindow::constructor_CairoWindow';
}
