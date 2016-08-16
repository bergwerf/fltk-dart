// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:async';

import 'package:fltk/fltk.dart' as fl;

/// Async version of callback.dart
Future main() {
  fl.scheme('gleam');
  var win = new fl.Window(300, 200, 'Click the button...');
  var but = new fl.Button(0, 0, win.w, win.h, 'ON');
  but.onCallback.listen((_) => but.label = but.label == 'ON' ? 'OFF' : 'ON');
  win.end();
  win.show();

  return fl.runAsync();
}
