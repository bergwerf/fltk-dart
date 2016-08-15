// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Text_Display
class TextDisplay extends Group {
  /// Cursor shape: I-beam
  static const NORMAL_CURSOR = 0;

  /// Cursor shape: caret under the text
  static const CARET_CURSOR = 1;

  /// Cursor shape: dim I-beam
  static const DIM_CURSOR = 2;

  /// Cursor shape: unfille box under the current character
  static const BLOCK_CURSOR = 3;

  /// Cursor shape: thick I-beam
  static const HEAVY_CURSOR = 4;

  /// Cursor shape: same as Fl_Input
  static const SIMPLE_CURSOR = 5;

  /// Public constuctor
  TextDisplay(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createTextDisplay(x, y, w, h, l);
  }

  TextDisplay.empty() : super.empty();

  /// Native constructor
  void _createTextDisplay(int x, int y, int w, int h, String l)
      native 'fldart::TextDisplay::constructor_TextDisplay';

  /// Set the [TextBuffer]
  set buffer(TextBuffer buffer) native 'fldart::TextDisplay::void_buffer';

  /// Get the cursor color.
  int get cursorColor native 'fldart::TextDisplay::uint32_t_cursor_color';

  /// Set the cursor color.
  set cursorColor(int color) native 'fldart::TextDisplay::void_cursor_color';

  /// Set the cursor style.
  set cursorStyle(int style) native 'fldart::TextDisplay::void_cursor_style';

  /// Get default text color.
  int get textColor native 'fldart::TextDisplay::Fl_Color_textcolor';

  /// Set default text color.
  set textColor(int color) native 'fldart::TextDisplay::void_textcolor';

  /// Get default text font.
  int get textFont native 'fldart::TextDisplay::Fl_Font_textfont';

  /// Set default text font.
  set textFont(int font) native 'fldart::TextDisplay::void_textfont';

  /// Get default text size.
  int get textSize native 'fldart::TextDisplay::Fl_Fontsize_textsize';

  /// Set default text size.
  set textSize(int size) native 'fldart::TextDisplay::void_textsize';
}
