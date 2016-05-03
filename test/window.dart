// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

int main(List<String> args) {
  var window = new fl.Window(500, 500, 'My custom label!');
  window.end();
  window.show();
  return fl.run();
}
