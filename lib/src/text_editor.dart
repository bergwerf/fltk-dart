// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Text_Editor
class TextEditor extends Widget {
  /// Public constuctor
  TextEditor(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createTextEditor(x, y, w, h, l);
  }

  TextEditor.empty() : super.empty();

  /// Native constructor
  void _createTextEditor(int x, int y, int w, int h, String l)
      native 'fldart::TextEditor::constructor_TextEditor';

  /// Set the [TextBuffer]
  set buffer(TextBuffer buffer) native 'fldart::TextEditor::void_buffer';
}
