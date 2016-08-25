// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:io';

import 'package:image/image.dart';
import 'package:fltk/fltk.dart' as fl;

int main() {
  fl.scheme('gleam');

  // Using a single buffered window gives issues with image alpha rendering.
  var window = new fl.DoubleWindow(160, 160);
  var btn = new fl.Button(20, 20, 120, 120);
  btn.image = decodeImage(new File('test/image.png').readAsBytesSync());
  window.end();
  window.resizable = btn;
  window.show();

  return fl.run();
}
