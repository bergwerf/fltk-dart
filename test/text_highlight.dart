// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

int main() {
  final window = new fl.DoubleWindow(120, 20, '');
  final editor = new fl.TextEditor(0, 0, window.w, window.h);
  editor.box = fl.FLAT_BOX;
  editor.deactivate();

  final buffer = new fl.TextBuffer();
  buffer.text = 'red, green, blue';
  editor.buffer = buffer;

  final styletable = [
    // A - Default
    new fl.StyleEntry(),
    // B - Red
    new fl.StyleEntry(color: fl.RED, font: fl.COURIER),
    // C - Green
    new fl.StyleEntry(color: fl.DARK_GREEN, font: fl.COURIER_ITALIC),
    // D - Blue
    new fl.StyleEntry(color: fl.BLUE, font: fl.COURIER_BOLD),
  ];
  final highlightBuffer = new fl.TextBuffer();
  highlightBuffer.text = 'BBBAACCCCCAADDDD';
  editor.highlightData(highlightBuffer, styletable);

  window.end();
  window.show();
  return fl.run();
}
