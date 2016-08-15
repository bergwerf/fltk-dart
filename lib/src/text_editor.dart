// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Text_Editor
class TextEditor extends Widget {
  /// Public constuctor
  TextEditor(int x, int y, int w, int h, [String l = '']) : super.empty() {
    ptr = _create(this, x, y, w, h, l);
  }

  TextEditor.empty() : super.empty();

  /// Set the [TextBuffer]
  set buffer(TextBuffer buffer) => _buffer(ptr, buffer.ptr);

  //////////////////////////////////////////////////////////////////////////////
  // Bindings with native code
  //////////////////////////////////////////////////////////////////////////////

  static int _create(TextEditor me, int x, int y, int w, int h, String l)
      native 'fldart::TextEditor::constructor_TextEditor';
  static void _buffer(int ptr, int buffer)
      native 'fldart::TextEditor::void_buffer';
}
