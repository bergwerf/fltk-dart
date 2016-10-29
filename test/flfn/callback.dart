// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:async';

import 'package:fltk/flfn.dart' as fl;

fl.App buildApp() => new fl.App(windows: {
      'main': new fl.Window(300, 200, 'Click the button...', children: {
        'btn-one': new fl.Button(0, 0, 150, 200, label: '1', box: fl.UP_BOX,
            callback: (app, button) {
          final btn = app.getButton('main/btn-two');
          btn.label = btn.label == 'ON' ? 'OFF' : 'ON';
        }),
        'btn-two': new fl.Button(150, 0, 150, 200, label: 'ON', box: fl.UP_BOX,
            callback: (app, button) {
          final btn = app.getButton('main/btn-one');
          btn.label = btn.label == '1' ? '0' : '1';
        })
      })
    }, scheme: 'plastic');

Future<int> main() async {
  return fl.runApp(buildApp);
}
