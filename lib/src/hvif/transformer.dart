// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.hvif;

/// HVIF transformer
abstract class HvifTransformer {
  /// Should the shape paths be filled?
  final bool doFill;

  HvifTransformer([this.doFill = true]);

  factory HvifTransformer.read(HvifBuffer buffer) {
    final code = buffer.read();
    switch (code) {
      case HvifAffineTransformer.code:
        return new HvifAffineTransformer(buffer);
      case HvifContourTransformer.code:
        return new HvifContourTransformer(buffer);
      case HvifPerspectiveTransformer.code:
        return new HvifPerspectiveTransformer(buffer);
      case HvifStrokeTransformer.code:
        return new HvifStrokeTransformer(buffer);
      default:
        throw new UnsupportedError('Unkown HVIF transformer code: $code');
    }
  }

  /// Code to run after a path is drawn.
  void afterPath(cairo.Context ctx, int size) {}
}

class HvifAffineTransformer extends HvifTransformer {
  static const code = 20;

  HvifAffineTransformer(HvifBuffer buffer) {
    throw new UnimplementedError('HvifAffineTransformer is not implemented.');
  }
}

class HvifContourTransformer extends HvifTransformer {
  static const code = 21;

  HvifContourTransformer(HvifBuffer buffer) {
    throw new UnimplementedError('HvifContourTransformer is not implemented.');
  }
}

class HvifPerspectiveTransformer extends HvifTransformer {
  static const code = 22;

  HvifPerspectiveTransformer(HvifBuffer buffer) {
    throw new UnimplementedError(
        'HvifPerspectiveTransformer is not implemented.');
  }
}

/// Equal to line_cap_e from AGG (Haiku uses AGG)
enum aggLineCap { buttCap, squareCap, roundCap }

/// Convert AGG line cap to Cairo line cap.
final aggToCairoLineCap = {
  aggLineCap.buttCap: cairo.LineCap.Butt,
  aggLineCap.squareCap: cairo.LineCap.Square,
  aggLineCap.roundCap: cairo.LineCap.Round
};

/// Equal to line_join_e from AGG (Haiku uses AGG)
enum aggLineJoin {
  miterJoin,
  miterJoinRevert,
  roundJoin,
  bevelJoin,
  miterJoinRound
}

/// Convert AGG line join to Cairo line join.
final aggToCairoLineJoin = {
  aggLineJoin.miterJoin: cairo.LineJoin.Miter,
  aggLineJoin.miterJoinRevert: cairo.LineJoin.Miter,
  aggLineJoin.roundJoin: cairo.LineJoin.Round,
  aggLineJoin.bevelJoin: cairo.LineJoin.Bevel,
  aggLineJoin.miterJoinRound: cairo.LineJoin.Round
};

class HvifStrokeTransformer extends HvifTransformer {
  static const code = 23;

  double lineWidth, miterLimit;
  cairo.LineCap lineCap;
  cairo.LineJoin lineJoin;

  HvifStrokeTransformer(HvifBuffer buffer) : super(false) {
    lineWidth = buffer.read() - 128.0;
    final lineOptions = buffer.read();
    miterLimit = buffer.read().toDouble();

    final lineJoinI = lineOptions & 15;
    lineJoin = aggToCairoLineJoin[aggLineJoin.values[lineJoinI]];
    final lineCapI = lineOptions >> 4;
    lineCap = aggToCairoLineCap[aggLineCap.values[lineCapI]];
  }

  void afterPath(cairo.Context ctx, int size) {
    ctx
      ..lineWidth = lineWidth
      ..miterLimit = miterLimit
      ..lineJoin = lineJoin
      ..lineCap = lineCap
      ..stroke();
  }
}
