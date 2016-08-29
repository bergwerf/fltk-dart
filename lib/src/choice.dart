// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Choice
class Choice extends Menu {
  /// Public constuctor
  Choice(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createChoice(x, y, w, h, l);
  }

  Choice.empty() : super.empty();

  /// Handle events.
  int doHandle(int event) => handle(Event.values[event]) ? 1 : 0;

  /// Native constructor
  void _createChoice(int x, int y, int w, int h, String l)
      native 'fldart::Choice::constructor_Choice';
}
