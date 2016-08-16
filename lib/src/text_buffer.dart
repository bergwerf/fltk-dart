// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// [TextBuffer.onModify] data
class TextBufferModifyData {
  final int pos, nInserted, nDeleted, nRestyled;
  final String deletedText;
  TextBufferModifyData(this.pos, this.nInserted, this.nDeleted, this.nRestyled,
      this.deletedText);
}

/// Fl_Text_Buffer
class TextBuffer extends NativeFieldWrapperClass2 {
  /// Buffer modified event stream
  Stream<TextBufferModifyData> onModify;

  /// Buffer modified event stream controller
  final _onModifyController =
      new StreamController<TextBufferModifyData>.broadcast();

  /// Public constuctor
  TextBuffer() {
    _createTextBuffer();

    // Setup onModify stream.
    onModify = _onModifyController.stream;
  }

  void bufferModified(
      int pos, int nInserted, int nDeleted, int nRestyled, String deletedText) {
    _onModifyController.add(new TextBufferModifyData(
        pos, nInserted, nDeleted, nRestyled, deletedText));
  }

  /// Native constructor
  void _createTextBuffer() native 'fldart::TextBuffer::constructor_TextBuffer';

  /// Get buffer text.
  String get text native 'fldart::TextBuffer::String_text';

  /// Set buffer text.
  set text(String text) native 'fldart::TextBuffer::void_text';
}
