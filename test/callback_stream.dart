// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

/// Event stream version of callback.dart
int main() {
  fl.useSyncStreams = true;
  fl.scheme = 'gleam';

  var window = new fl.Window(300, 200, 'Click the button...');
  var button = new fl.Button(0, 0, window.w(), window.h(), 'ON');
  button.onCallback
      .listen((_) => button.label = button.label == 'ON' ? 'OFF' : 'ON');
  window.end();
  window.show();

  return fl.run();
}
