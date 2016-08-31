// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:math';

import 'package:cairodart/cairodart.dart';
import 'package:fltk/fltk.dart' as fl;

int main() {
  final window = new fl.DoubleWindow(720, 480, 'Dart');
  final surface = new fl.CairoSurface(0, 0, window.w(), window.h());

  int x, y, xo, yo;
  final blue = new Random().nextDouble();
  final ctx = surface.getContext();
  ctx
    ..setSourceRgb(1, 1, 1)
    ..paint()
    ..setSourceRgb(0, 0, 0)
    ..lineWidth = 5.0
    ..lineJoin = LineJoin.Round;

  surface.addHandler((event, data) {
    switch (event) {
      case fl.Event.PUSH:
        // Update position.
        x = data.x;
        y = data.y;
        xo = x;
        yo = y;
        return true;

      case fl.Event.DRAG:
        // Draw line segment
        ctx
          ..moveTo(xo, yo)
          ..lineTo(x, y)
          ..lineTo(data.x, data.y)
          ..setSourceRgb(x / surface.w(), y / surface.h(), blue)
          ..stroke();
        surface.redraw();

        // Update position.
        xo = x;
        yo = y;
        x = data.x;
        y = data.y;
        return true;

      default:
        return false;
    }
  });

  window.show();

  return fl.run();
}
