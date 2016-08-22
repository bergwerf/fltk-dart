// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_Menu_
class Menu extends Widget {
  Menu.empty() : super.empty();

  void _add(String label, int shortcut, Function callback, int flags)
      native 'fldart::Menu::void_add';

  /// Add menu item.
  void add(String label,
      {Shortcut shortcut: const Shortcut(0),
      Callback callback: null,
      dynamic userData: null,
      int flags: 0}) {
    if (callback != null) {
      _add(label, shortcut.value, () => callback(this, userData), flags);
    } else {
      _add(label, shortcut.value, null, flags);
    }
  }
}
