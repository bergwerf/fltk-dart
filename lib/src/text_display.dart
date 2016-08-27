// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Style_Table_Entry
class StyleEntry {
  final int color;
  final int font;
  final int size;

  /// Default contructor
  StyleEntry({this.color: BLACK, this.font: HELVETICA, this.size: 14});
}

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

  /// Get line number alignment.
  int get linenumberAlign
      native 'fldart::TextDisplay::Fl_Align_linenumber_align';

  /// Set line number text alignment.
  ///
  /// Valid values:
  /// - [ALIGN_LEFT]
  /// - [ALIGN_CENTER]
  /// - [ALIGN_RIGHT]
  set linenumberAlign(int val)
      native 'fldart::TextDisplay::void_linenumber_align';

  /// Get line number background color.
  int get linenumberBgColor
      native 'fldart::TextDisplay::Fl_Color_linenumber_bgcolor';

  /// Set line number background color.
  set linenumberBgColor(int val)
      native 'fldart::TextDisplay::void_linenumber_bgcolor';

  /// Get line number foreground color.
  int get linenumberFgColor
      native 'fldart::TextDisplay::Fl_Color_linenumber_fgcolor';

  /// Set line number foreground color.
  set linenumberFgColor(int val)
      native 'fldart::TextDisplay::void_linenumber_fgcolor';

  /// Get line number font.
  int get linenumberFont native 'fldart::TextDisplay::Fl_Font_linenumber_font';

  /// Set line number font.
  set linenumberFont(int val)
      native 'fldart::TextDisplay::void_linenumber_font';

  /// Get line number print format.
  String get linenumberFormat
      native 'fldart::TextDisplay::String_linenumber_format';

  /// Set line number print format.
  set linenumberFormat(String val)
      native 'fldart::TextDisplay::void_linenumber_format';

  /// Get line number font size.
  int get linenumberSize
      native 'fldart::TextDisplay::Fl_Fontsize_linenumber_size';

  /// Set line number font size.
  set linenumberSize(int val)
      native 'fldart::TextDisplay::void_linenumber_size';

  /// Get line number pixel width.
  int get linenumberWidth native 'fldart::TextDisplay::int_linenumber_width';

  /// Set line number pixel width.
  set linenumberWidth(int width)
      native 'fldart::TextDisplay::void_linenumber_width';

  /// Scroll to the given row and collumn.
  void scroll(int row, int collumn) native 'fldart::TextDisplay::void_scroll';

  /// Set the text highlighting data.
  void highlightData(TextBuffer buffer, List<StyleEntry> styletable)
      native 'fldart::TextDisplay::void_highlight_data';

  void _scrollbarBox(int boxtype)
      native 'fldart::TextDisplay::void_set_scrollbar_box';

  /// Set boxtype of the horizontal and vertical scrollbar.
  set scrollbarBox(Boxtype boxtype) => _scrollbarBox(boxtype.index);

  /// Set color of the horizontal and vertical scrollbar track.
  set scrollbarTrackColor(int color)
      native 'fldart::TextDisplay::void_set_scrollbar_color';
}
