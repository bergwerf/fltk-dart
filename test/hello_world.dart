// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

int main(List<String> args) {
  fl.scheme('gleam');
  var window = new fl.Window(300, 180, 'FLTK');
  var box = new fl.Box(20, 40, 260, 100, 'Hello, World!');
  box.box(fl.UP_BOX);
  box.labelsize(36);
  //box.labelfont(fl.BOLD + fl.ITALIC);
  box.labeltype(fl.SHADOW_LABEL);
  window.end();
  window.show();
  return fl.run();
}
