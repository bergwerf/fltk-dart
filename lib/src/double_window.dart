// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Double_Window
class DoubleWindow extends Window {
  /// Public constuctor
  DoubleWindow(int w, int h, [String l = '']) : super.empty() {
    ptr = _create(w, h, l);
  }

  DoubleWindow.empty() : super.empty();

  // Bindings with native code
  static int _create(int w, int h, String l)
      native 'fldart::DoubleWindow::createDoubleWindowShort';
}
