// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Button
class Button extends Widget {
  /// Public constuctor
  Button(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createButton(x, y, w, h, l);
  }

  Button.empty() : super.empty();

  /// Handle events.
  int doHandle(int event) => handle(Event.values[event]) ? 1 : 0;

  /// Native constructor
  void _createButton(int x, int y, int w, int h, String l)
      native 'fldart::Button::constructor_Button';
}
