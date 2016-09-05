// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:fltk/hvif.dart';
import 'package:fltk/fltk.dart' as fl;

const hvifRedMarble = const [
  0x6e, 0x63, 0x69, 0x66, 0x02, 0x02, 0x01, 0x06,
  //
  0x03, 0x3e, 0x7f, 0xff, 0x00, 0x00, 0x00, 0x00,
  //
  0x00, 0x00, 0x3e, 0x80, 0x00, 0x49, 0x00, 0x00,
  //
  0x49, 0x00, 0x00, 0x00, 0xff, 0xce, 0xce, 0x8d,
  //
  0xd7, 0x05, 0x05, 0xff, 0x46, 0x01, 0x01, 0x03,
  //
  0x18, 0x00, 0x7f, 0x02, 0x02, 0x04, 0x24, 0x40,
  //
  0x24, 0x30, 0x24, 0x50, 0x40, 0x5c, 0x30, 0x5c,
  //
  0x50, 0x5c, 0x5c, 0x40, 0x5c, 0x50, 0x5c, 0x30,
  //
  0x40, 0x24, 0x50, 0x24, 0x30, 0x24, 0x0a, 0x0c,
  //
  0x37, 0x32, 0x37, 0x4d, 0x3c, 0x4d, 0x3c, 0x42,
  //
  0x46, 0x42, 0x46, 0x4d, 0x4b, 0x4d, 0x4b, 0x32,
  //
  0x46, 0x32, 0x46, 0x3d, 0x3c, 0x3d, 0x3c, 0x32,
  //
  0x02, 0x0a, 0x00, 0x01, 0x00, 0x00, 0x0a, 0x01,
  //
  0x01, 0x01, 0x28, 0x1e, 0x20, 0x13, 0xff
];

int main() {
  final window = new fl.DoubleWindow(96 + 48 + 24, 96);
  final hvif96 = new fl.Box(0, 0, 96, 96);
  final hvif32 = new fl.Box(96, 0, 48, 96);
  final hvif16 = new fl.Box(96 + 48, 0, 24, 96);
  hvif96.image = hvifRender(new Uint8List.fromList(hvifRedMarble), 96);
  hvif32.image = hvifRender(new Uint8List.fromList(hvifRedMarble), 32);
  hvif16.image = hvifRender(new Uint8List.fromList(hvifRedMarble), 16);
  window.end();
  window.show();
  return fl.run();
}