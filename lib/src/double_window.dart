// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Double_Window
class DoubleWindow extends Window {
  /// Create window with the given dimensions
  DoubleWindow(int w, int h, [String l = '']) : super.empty() {
    _createDoubleWindow(w, h, l);
  }

  /// Create window with the given dimensions at the given position.
  DoubleWindow.at(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createDoubleWindowAt(x, y, w, h, l);
  }

  DoubleWindow.empty() : super.empty();

  /// Short native constructor
  void _createDoubleWindow(int w, int h, String l)
      native 'fldart::DoubleWindow::constructor_DoubleWindowShort';

  /// Native constructor
  void _createDoubleWindowAt(int x, int y, int w, int h, String l)
      native 'fldart::DoubleWindow::constructor_DoubleWindow';
}
