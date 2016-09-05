// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.hvif;

/// HVIF styles
enum HvifStyleType {
  none,
  solidColor,
  gadient,
  solidColorNoAlpha,
  solidGray,
  solidGrayNoAlpha
}

/// HVIF gradient types
enum HvifGradientType { linear, circular, diamond, conic, xy, sqrtXy }

/// HVIF gradient flags
const hvifGradientFlagTransform = 1 << 1;
const hvifGradientFlagNoAlpha = 1 << 2;
const hvifGradientFlag16BitColors = 1 << 3; // Not implemented
const hvifGradientFlagGrays = 1 << 4;

/// HVIF style data
class HvifStyle {
  HvifStyleType style;
  HvifGradientType gradient;
  final matrix = new cairo.Matrix.zero();
  int gradientFlags;
  final colors = new List<cairo.Color>();
  final stopValues = new List<int>();

  HvifStyle(HvifBuffer buffer) {
    style = HvifStyleType.values[buffer.read()];
    switch (style) {
      case HvifStyleType.solidColor:
      case HvifStyleType.solidColorNoAlpha:
      case HvifStyleType.solidGray:
      case HvifStyleType.solidGrayNoAlpha:
        colors.add(hvifReadColor(
            buffer,
            style == HvifStyleType.solidGray ||
                style == HvifStyleType.solidGrayNoAlpha,
            style == HvifStyleType.solidColorNoAlpha ||
                style == HvifStyleType.solidGrayNoAlpha));
        break;

      case HvifStyleType.gadient:
        gradient = HvifGradientType.values[buffer.read()];
        gradientFlags = buffer.read();
        int gradientStops = buffer.read();

        // Read 6x24bit affine transformation matrix.
        if (gradientFlags & hvifGradientFlagTransform != 0) {
          matrix.init(
              hvifReadFloat24(buffer),
              hvifReadFloat24(buffer),
              hvifReadFloat24(buffer),
              hvifReadFloat24(buffer),
              hvifReadFloat24(buffer),
              hvifReadFloat24(buffer));
        }

        // Read gradient color stops.
        while (gradientStops-- > 0) {
          stopValues.add(buffer.read());
          colors.add(hvifReadColor(
              buffer,
              gradientFlags & hvifGradientFlagGrays != 0,
              gradientFlags & hvifGradientFlagNoAlpha != 0));
        }
        break;

      default:
        throw new UnsupportedError('HVIF uses unknown style type.');
    }
  }

  void configure(cairo.Context ctx, int size) {
    if (style == HvifStyleType.gadient) {
      final scale = 64 / size;
      if (gradient == HvifGradientType.circular) {
        final radialGradient = new cairo.RadialGradient(0, 0, 0, 0, 0, 64);

        // Note! It turns out you need to invert the matrix for Cairo.
        radialGradient.matrix = matrix
          ..invert()
          ..scale(scale, scale);

        // Add color stops.
        for (var i = 0; i < stopValues.length; i++) {
          radialGradient.addColorStop(
              new cairo.ColorStop(colors[i], stopValues[i] / 255));
        }

        ctx.source = radialGradient;
      }
    } else {
      final c = colors[0];
      ctx.setSourceRgba(c.red, c.green, c.blue, c.alpha);
    }
  }
}
