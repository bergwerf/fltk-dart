// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:io';

import 'package:image/image.dart';
import 'package:fltk/fltk.dart' as fl;

int main() {
  // Using a single buffered window gives issues with image alpha rendering.
  var window = new fl.DoubleWindow(64, 64);
  var button = new fl.Box(0, 0, 64, 64);
  button.image = decodeImage(new File('example/image.png').readAsBytesSync());
  window.end();
  window.show();
  return fl.run();
}
