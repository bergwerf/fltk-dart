// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Text_Buffer
class TextBuffer extends NativeFieldWrapperClass2 {
  /// Public constuctor
  TextBuffer() {
    _createTextBuffer();
  }

  /// Native constructor
  void _createTextBuffer() native 'fldart::TextBuffer::constructor_TextBuffer';
}
