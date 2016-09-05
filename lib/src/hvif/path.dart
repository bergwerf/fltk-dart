// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.hvif;

/// HVIF path flags
const hvifPathFlagClosed = 1 << 1;
const hvifPathFlagUsesCommands = 1 << 2;
const hvifPathFlagNoCurves = 1 << 3;

/// HVIF path commands
enum HvifPathCommand { hLine, vLine, line, curve }

/// HVIF path data
class HvifPath {
  int flags;
  bool closed, usesCommands, noCurves;
  List<HvifPoint> points;

  HvifPath(HvifBuffer buffer) {
    flags = buffer.read();
    closed = flags & hvifPathFlagClosed != 0;
    usesCommands = flags & hvifPathFlagUsesCommands != 0;
    noCurves = flags & hvifPathFlagNoCurves != 0;
    int npoints = buffer.read();

    if (usesCommands) {
      // Read command bits.
      throw new UnimplementedError('Command paths are not implemented.');
    } else if (noCurves) {
      // npoints * 2 coords per point
      points = new List<HvifPoint>.generate(
          npoints, (_) => new HvifPoint.line(buffer));
    } else {
      // npoints * 6 coords per point
      points = new List<HvifPoint>.generate(
          npoints, (_) => new HvifPoint.curve(buffer));
    }
  }

  void render(cairo.Context ctx, int size, List<HvifTransformer> transformers) {
    if (points.isNotEmpty) {
      final scale = size / 64;
      ctx.matrix = new cairo.Matrix.zero()..initScale(scale, scale);
      ctx.moveTo(points.first.x, points.first.y);

      for (var i = 0; i < points.length; i++) {
        final point = points[i];
        if (point.isCurve) {
          final next = i + 1 == points.length ? points.first : points[i + 1];
          ctx.curveTo(
              point.xOut, point.yOut, next.xIn, next.yIn, next.x, next.y);
        } else {
          ctx.lineTo(point.x, point.y);
        }
      }

      if (closed) {
        ctx.closePath();
      }

      // Run transformers.
      bool doFill = true;
      for (final transformer in transformers) {
        doFill = doFill ? transformer.doFill : doFill;
        transformer.afterPath(ctx, size);
      }

      if (doFill) {
        ctx.fill();
      }
    }
  }
}
