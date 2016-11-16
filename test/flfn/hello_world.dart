// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:async';

import 'package:color/color.dart';
import 'package:fltk/flfn.dart' as fl;

fl.App buildApp() => new fl.App(windows: {
      'window': new fl.Window(350, 180, 'FLTK', children: {
        'box': new fl.Box(20, 40, 310, 100,
            label: 'Hi, World!',
            box: fl.DOWN_BOX,
            labelsize: 36,
            labelfont: fl.COURIER,
            labeltype: fl.SHADOW_LABEL,
            labelcolor: fl.YELLOW,
            color: new RgbColor.name('cyan'))
      })
    }, scheme: 'gtk+');

Future<int> main() {
  return fl.runApp(buildApp);
}
