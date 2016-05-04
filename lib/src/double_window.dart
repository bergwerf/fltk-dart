// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Double_Window
class DoubleWindow extends Window {
  /// Public constuctor
  factory DoubleWindow(int w, int h, [String l = '']) {
    return new DoubleWindow.fromPtr(_create(w, h, l));
  }

  /// Internal constuctor
  DoubleWindow.fromPtr(int ptr) : super.fromPtr(ptr);

  // Bindings with native code
  static int _create(int w, int h, String l)
      native 'fldart::DoubleWindow::createDoubleWindowShort';
}
