// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library fltk.cairoutils;

import 'dart:typed_data';

/// Convert BGRA buffer to RGBA buffer.
void bgraToRgba(Uint8List src) {
  for (var i = 0; i < src.length; i += 4) {
    // Swap r and b.
    final b = src[i];
    src[i] = src[i + 2];
    src[i + 2] = b;
  }
}

/// Convert premultiplied RGBA to straight RGBA.
void unpremultiply(Uint8List src) {
  for (var i = 0; i < src.length; i += 2) {
    final a = src[i + 3] / 255;
    if (a > 0) {
      if (src[i] > 0) {
        src[i] = (src[i] / a).round();
      }
      i++;
      if (src[i] > 0) {
        src[i] = (src[i] / a).round();
      }
      i++;
      if (src[i] > 0) {
        src[i] = (src[i] / a).round();
      }
    } else {
      i += 2;
    }
  }
}
