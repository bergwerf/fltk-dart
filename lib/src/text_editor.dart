// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Text_Editor
class TextEditor extends TextDisplay {
  /// Public constuctor
  TextEditor(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createTextEditor(x, y, w, h, l);
  }

  TextEditor.empty() : super.empty();

  /// Native constructor
  void _createTextEditor(int x, int y, int w, int h, String l)
      native 'fldart::TextEditor::constructor_TextEditor';

  void _scrollbarBox(int boxtype)
      native 'fldart::TextEditor::void_set_scrollbar_box';

  /// Set boxtype of the horizontal and vertical scrollbar.
  set scrollbarBox(Boxtype boxtype) => _scrollbarBox(boxtype.index);

  /// Set color of the horizontal and vertical scrollbar track.
  set scrollbarTrackColor(int color)
      native 'fldart::TextEditor::void_set_scrollbar_color';
}
