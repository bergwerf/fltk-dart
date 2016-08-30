// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:math';

import 'package:cairodart/cairodart.dart';
import 'package:fltk/fltk.dart' as fl;

int main() {
  final window = new fl.DoubleWindow(300, 300, 'Dart');
  final surface = new fl.CairoSurface(10, 10, window.w() - 20, window.h() - 20);

  window.resizable = surface;
  window.color = fl.DARK_GREEN;

  // Variables to test resize events.
  var cx = surface.w() / 2, cy = surface.h() / 2;

  // Set resize listener.
  surface.onResize.listen((data) {
    cx = data.w / 2;
    cy = data.h / 2;
  });

  // Set cairo draw listener.
  surface.onDraw.listen((Context ctx) {
    ctx.lineWidth = 1.0;

    // Final variables
    final r1 = 80, r2 = 40;

    ctx.save();
    ctx
      ..operator = Operator.Source
      ..setSourceRgba(1, 1, 1, 0.5)
      ..paint();
    ctx.restore();

    // Red circle
    var a = PI / 2;
    ctx
      ..save()
      ..translate(cx + r2 * cos(a), cy - r2 * sin(a))
      ..setSourceRgb(0, 0, 0)
      ..arc(0, 0, r1, 0, 2 * PI)
      ..strokePreserve()
      ..setSourceRgba(1, 0, 0, 0.7)
      ..fill()
      ..restore();

    // Green circle
    a = PI / 6 * 7;
    ctx
      ..save()
      ..translate(cx + r2 * cos(a), cy - r2 * sin(a))
      ..setSourceRgb(0, 0, 0)
      ..arc(0, 0, r1, 0, 2 * PI)
      ..strokePreserve()
      ..setSourceRgba(0, 1, 0, 0.7)
      ..fill()
      ..restore();

    // Blue circle
    a = PI / 6 * -1;
    ctx
      ..save()
      ..translate(cx + r2 * cos(a), cy - r2 * sin(a))
      ..setSourceRgb(0, 0, 0)
      ..arc(0, 0, r1, 0, 2 * PI)
      ..strokePreserve()
      ..setSourceRgba(0, 0, 1, 0.7)
      ..fill()
      ..restore();
  });

  window.show();

  return fl.run();
}
