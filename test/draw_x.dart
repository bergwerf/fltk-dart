// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

/// Widget that draws two diagonal lines
class XWidget extends fl.Widget {
  /// Constuctor
  XWidget(int x, int y, int w, int h) : super(x, y, w, h, '');

  /// Draws the lines
  void draw() {
    fl.color(fl.BLACK);
    int x1 = x(), y1 = y();
    int x2 = x() + w() - 1, y2 = y() + h() - 1;
    fl.line(x1, y1, x2, y2);
    fl.line(x1, y2, x2, y1);
  }
}

int main() {
  var win = new fl.DoubleWindow(200, 200, 'X');
  var x = new XWidget(0, 0, win.w(), win.h());
  win.resizable(x);
  win.show();
  return fl.run();
}
