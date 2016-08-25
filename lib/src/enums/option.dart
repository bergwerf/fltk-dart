// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

// Fl_Option
enum Option {
  /// When switched on, moving the text cursor beyond the start or end of a text
  /// in a text widget will change focus to the next text widget.
  /// (This is considered 'old' behavior)
  ///
  /// When switched off (default), the cursor will stop at the end of the text.
  /// Pressing Tab or Ctrl-Tab will advance the keyboard focus.
  ARROW_FOCUS,

  /// If visible focus is switched on (default), FLTK will draw a dotted
  /// rectangle inside the widget that will receive the next keystroke.
  ///
  /// If switched off, no such indicator will be drawn and keyboard navigation
  /// is disabled.
  VISIBLE_FOCUS,

  /// If text drag-and-drop is enabled (default), the user can select and drag
  /// text from any text widget.
  ///
  /// If disabled, no dragging is possible, however dropping text from other
  /// applications still works.
  DND_TEXT,

  /// If tooltips are enabled (default), hovering the mouse over a widget with a
  /// tooltip text will open a little tooltip window until the mouse leaves the
  /// widget.
  ///
  /// If disabled, no tooltip is shown.
  SHOW_TOOLTIPS,

  /// When switched on (default), Fl_Native_File_Chooser runs GTK file dialogs
  /// if the GTK library is available on the platform (linux/unix only).
  ///
  /// When switched off, GTK file dialogs aren't used even if the GTK library is
  /// available.
  FNFC_USES_GTK,

  /// For internal use only
  LAST
}
