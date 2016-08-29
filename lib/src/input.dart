// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Input
class Input extends Widget {
  /// Public constuctor
  Input(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createInput(x, y, w, h, l);
  }

  Input.empty() : super.empty();

  /// Handle events.
  int doHandle(int event) => handle(Event.values[event]) ? 1 : 0;

  /// Native constructor
  void _createInput(int x, int y, int w, int h, String l)
      native 'fldart::Input::constructor_Input';
}
