// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.hvif;

/// Helper class for storing points
class HvifPoint {
  final num x, y;
  final bool isCurve;
  final num xIn, yIn, xOut, yOut; // Used by curves.

  HvifPoint(
      this.x, this.y, this.isCurve, this.xIn, this.yIn, this.xOut, this.yOut);

  factory HvifPoint.line(HvifBuffer buffer) {
    return new HvifPoint(
        hvifReadCoord(buffer), hvifReadCoord(buffer), false, 0, 0, 0, 0);
  }

  factory HvifPoint.hLine(HvifBuffer buffer, HvifPoint prev) {
    return new HvifPoint(hvifReadCoord(buffer), prev.y, false, 0, 0, 0, 0);
  }

  factory HvifPoint.vLine(HvifBuffer buffer, HvifPoint prev) {
    return new HvifPoint(prev.x, hvifReadCoord(buffer), false, 0, 0, 0, 0);
  }

  factory HvifPoint.curve(HvifBuffer buffer) {
    return new HvifPoint(
        hvifReadCoord(buffer),
        hvifReadCoord(buffer),
        true,
        hvifReadCoord(buffer),
        hvifReadCoord(buffer),
        hvifReadCoord(buffer),
        hvifReadCoord(buffer));
  }

  String toString() => 'HvifPoint($x, $y, $isCurve, $xIn, $yIn, $xOut, $yOut)';
}

/// Uint8List wrapper
class HvifBuffer {
  final Uint8List data;
  int index = 0;
  HvifBuffer(this.data);
  int read() {
    if (data.length > index++) {
      return data[index - 1];
    } else {
      throw new RangeError('There is no next element in the data array.');
    }
  }
}

/// Read color.
cairo.Color hvifReadColor(HvifBuffer buffer, bool gray, bool noAlpha) {
  final r = buffer.read();
  final g = gray ? r : buffer.read();
  final b = gray ? r : buffer.read();
  final a = noAlpha ? 255 : buffer.read();
  return new cairo.Color.rgba(r / 255, g / 255, b / 255, a / 255);
}

/// Read coordinate.
double hvifReadCoord(HvifBuffer buffer) {
  var value = buffer.read();
  if (value & 128 != 0) {
    // The 8th bit is set, the next byte is part of the coord.
    value &= 127;
    value = (value << 8) | buffer.read();
    return value / 102.0 - 128.0;
  } else {
    // Simple coord
    return value - 32.0;
  }
}

/// Read 24bit float (special HVIF format).
double hvifReadFloat24(HvifBuffer buffer) {
  int shortValue = (buffer.read() << 16) | (buffer.read() << 8) | buffer.read();
  if (shortValue == 0) {
    return 0.0;
  } else {
    int sign = (shortValue & 0x800000) >> 23;
    int exponent = ((shortValue & 0x7e0000) >> 17) - 32;
    int mantissa = (shortValue & 0x01ffff) << 6;

    // Typed data trick to cast to floating point.
    final uint32 = new Uint32List(1);
    uint32[0] = (sign << 31) | ((exponent + 127) << 23) | mantissa;
    final float32 = new Float32List.view(uint32.buffer);
    return float32[0];
  }
}

/// Read LOD scale value.
double hvifReadLodValue(HvifBuffer buffer) => buffer.read() / 63.75;
