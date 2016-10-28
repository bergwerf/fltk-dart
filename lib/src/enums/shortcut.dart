// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.enums;

/// Mimick FLTK shortcut interface.
class Shortcut {
  final int value;

  const Shortcut(this.value);

  Shortcut operator +(dynamic data) {
    if (data is Shortcut) {
      return new Shortcut(value + data.value);
    } else if (data is String) {
      if (data.length == 1) {
        return new Shortcut(value + data.codeUnitAt(0));
      } else {
        throw new ArgumentError('data.length != 1');
      }
    } else {
      throw new ArgumentError('Illegal type');
    }
  }
}

/// Event states
const CTRL = const Shortcut(0x00040000);
