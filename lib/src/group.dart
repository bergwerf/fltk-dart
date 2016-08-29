// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Group
class Group extends Widget {
  /// Public constuctor
  Group(int x, int y, int w, int h, [String l = '']) : super.empty() {
    _createGroup(x, y, w, h, l);
  }

  Group.empty() : super.empty();

  /// Handle events.
  int doHandle(int event) => handle(Event.values[event]) ? 1 : 0;

  /// Native constructor
  void _createGroup(int x, int y, int w, int h, String l)
      native 'fldart::Group::constructor_Group';

  /// End group.
  void end() native 'fldart::Group::void_end';

  /// Set resizable widget.
  set resizable(Widget o) native 'fldart::Group::void_resizable';
}
