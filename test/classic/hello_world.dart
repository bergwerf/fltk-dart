// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:color/color.dart';
import 'package:fltk/fltk.dart' as fl;

int main() {
  fl.scheme = 'gleam';
  var window = new fl.Window(350, 180, 'FLTK');
  var box = new fl.Box(20, 40, 310, 100, 'Hello, World!');
  box.box = fl.UP_BOX;
  box.labelsize = 36;
  box.labelfont = fl.BOLD + fl.ITALIC;
  box.labeltype = fl.SHADOW_LABEL;
  box.labelcolor = fl.YELLOW;
  box.color = fl.toColor(new HexColor('#ff0000'));
  window.end();
  window.show();

  return fl.run();
}
