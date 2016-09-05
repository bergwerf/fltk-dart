// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.hvif;

/// Render HVIF vector data into an [Image] with the specified [size] using
/// Cairo.
Image hvifRender(Uint8List data, int size) {
  final buffer = new HvifBuffer(data);

  // Check magic number.
  if (buffer.read() == 110 &&
      buffer.read() == 99 &&
      buffer.read() == 105 &&
      buffer.read() == 102) {
    // Parse styles.
    final nstyles = buffer.read();
    final styles =
        new List<HvifStyle>.generate(nstyles, (_) => new HvifStyle(buffer));

    // Parse paths.
    final npaths = buffer.read();
    final paths =
        new List<HvifPath>.generate(npaths, (_) => new HvifPath(buffer));

    // Parse shapes.
    final nshapes = buffer.read();
    final shapes =
        new List<HvifShape>.generate(nshapes, (_) => new HvifShape(buffer));

    // Render shapes.
    final surface = new cairo.ImageSurface(cairo.Format.ARGB32, size, size);
    final ctx = new cairo.Context(surface);
    for (final shape in shapes) {
      shape.render(ctx, size, styles, paths);
    }

    // Create image.
    surface.flush();
    final pixeldata = surface.data;
    bgraToRgba(pixeldata);
    unpremultiply(pixeldata);
    return new Image.fromBytes(size, size, pixeldata);
  } else {
    throw new ArgumentError('The provided data is not HVIF data.');
  }
}
