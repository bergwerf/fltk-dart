// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

/// A simple text editor using FLTK and Dart, inspired by the 'Designing a
/// Simple Text Editor' tutorial from FLTK.

import 'package:fltk/fltk.dart' as fl;

class ReplaceBar extends fl.Group {
  fl.Input findInput;
  fl.Input replaceInput;
  fl.Button findButton;
  fl.Button replaceButton;

  ReplaceBar(int x, int y, int w, int h) : super(x, y, w, h);
}

class TextEditor extends fl.DoubleWindow {
  /// The editing field
  fl.TextEditor editor;

  /// Text buffer for the editor
  fl.TextBuffer buffer;

  /// Constructor
  TextEditor(int w, int h, String l) : super(w, h, l) {
    buffer = new fl.TextBuffer();
    editor = new fl.TextEditor(0, 0, w, h);
    editor.box(fl.FLAT_BOX);
    editor.buffer(buffer);
    resizable(editor);
    end();
  }
}

int main() {
  fl.scheme('gleam');
  var editor = new TextEditor(720, 480, 'Text editor');
  editor.show();
  return fl.run();
}
