// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.hvif;

const hvifShapeTypePathSource = 10;

/// HVIF shape flags
const hvifShapeFlagTransform = 1 << 1;
const hvifShapeFlagHinting = 1 << 2;
const hvifShapeFlagLodScale = 1 << 3;
const hvifShapeFlagHasTransformers = 1 << 4;
const hvifShapeFlagTranslation = 1 << 5;

/// HVIF shape data
class HvifShape {
  int type, style, flags;
  List<int> pathIndices;
  num translateX = 0, translateY = 0;
  num lodMin = 0, lodMax = 4;

  HvifShape(HvifBuffer buffer) {
    type = buffer.read();
    if (type == hvifShapeTypePathSource) {
      style = buffer.read();
      pathIndices = new List<int>.generate(buffer.read(), (_) => buffer.read());
      flags = buffer.read();

      if (flags & hvifShapeFlagTranslation != 0) {
        translateX = hvifReadCoord(buffer);
        translateY = hvifReadCoord(buffer);
      }

      if (flags & hvifShapeFlagLodScale != 0) {
        lodMin = hvifReadLodValue(buffer);
        lodMax = hvifReadLodValue(buffer);
      }
    } else {
      throw new UnsupportedError('HVIF contains unknown shape type $type.');
    }
  }

  void render(cairo.Context ctx, int size, List<HvifStyle> styles,
      List<HvifPath> paths) {
    // Check LOD.
    final lod = size / 64;
    if (lod > lodMin && lod <= lodMax) {
      ctx.save();

      // Apply translation.
      ctx.translate(translateX, translateY);

      // Switch to shape style.
      styles[style].configure(ctx, size);

      // Draw paths.
      for (final i in pathIndices) {
        paths[i].render(ctx, size);
      }

      ctx.restore();
    }
  }
}
