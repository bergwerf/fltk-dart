// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Group
class Group extends Widget {
  /// Public constuctor
  factory Group(int x, int y, int w, int h, [String l = '']) {
    return new Group.fromPtr(_create(x, y, w, h, l));
  }

  /// Internal constuctor
  Group.fromPtr(int ptr) : super.fromPtr(ptr);

  /// End group.
  void end() => _end(ptr);

  /// Set resizable widget.
  void resizable(Widget o) => _resizable(ptr, o.ptr);

  // Bindings with native code
  static int _create(int x, int y, int w, int h, String l)
      native 'fldart::Group::createGroup';
  static void _end(int ptr) native 'fldart::Group::end';
  static void _resizable(int ptr, int o) native 'fldart::Group::resizable';
}
