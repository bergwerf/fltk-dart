// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Text_Buffer
class TextBuffer extends _Ptr {
  /// Public constuctor
  TextBuffer() {
    ptr = _create();
  }

  //////////////////////////////////////////////////////////////////////////////
  // Bindings with native code
  //////////////////////////////////////////////////////////////////////////////

  static int _create() native 'fldart::TextBuffer::createTextBuffer';
}
