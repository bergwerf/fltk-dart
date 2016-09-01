// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Convert color to [Image] compatible Uint32 color.
int _colorToImageColor(Color c) {
  final rgb = c.toRgbColor();
  return rgb.r.toInt() |
      rgb.g.toInt() << 8 & 0xff00 |
      rgb.b.toInt() << 16 & 0xff0000 |
      255 << 24;
}

/// Read an XPM image and return an [Image] instance from the `image` library.
Image readXpm(List<String> xpm) {
  final dimRegex = new RegExp('([0-9]+) ([0-9]+) ([0-9]+) ([0-9]+)');

  if (xpm.isEmpty) {
    throw new ArgumentError('xpm cannot be empty');
    return null;
  }

  var match = dimRegex.firstMatch(xpm[0]);
  if (match == null) {
    throw new ArgumentError('xpm is not formatted correctly');
    return null;
  }

  // Parse dimensions.
  final width = int.parse(match.group(1));
  final height = int.parse(match.group(2));
  final ncolors = int.parse(match.group(3));
  final charspp = int.parse(match.group(4));

  // Read colors.
  final colRegex = new RegExp('(.{$charspp}).+c (.+)');
  final colors = new Map<String, int>();
  for (var i = 1; i <= ncolors; i++) {
    match = colRegex.firstMatch(xpm[i]);
    if (match == null) {
      throw new ArgumentError('xpm is not formatted correctly');
      return null;
    }

    final colorString = match.group(2).toLowerCase();
    int color = 0;
    if (colorString != 'none') {
      // [RgbColor.namedColors] color keys do not contain spaces.
      final colorNoSpaces = colorString.replaceAll(' ', '');
      if (RgbColor.namedColors.containsKey(colorNoSpaces)) {
        // Use named color.
        color = _colorToImageColor(RgbColor.namedColors[colorNoSpaces]);
      } else {
        // Parse as full hex color.
        color = _colorToImageColor(new HexColor(colorString));
      }
    }

    colors[match.group(1)] = color;
  }

  // Read pixels.
  final bytes = new Uint32List(width * height);
  for (var y = 0, p = 0; 1 + ncolors + y < xpm.length && y < height; y++) {
    final i = 1 + ncolors + y;
    for (var x = 0; x < xpm[i].length && x < width * charspp; x += charspp) {
      final colorKey = xpm[i].substring(x, x + charspp);
      bytes[p++] = colors[colorKey];
    }
  }

  // Create image.
  return new Image.fromBytes(width, height, bytes);
}

/// XPM data for a 32x32 pixels version of the Dart icon!
const xpmDartIcon = const [
  '32 32 5 2',
  '## c #0082c8',
  '++ c #00a4e4',
  ':: c #00d2b8',
  '.. c #55ddcA',
  '   c None',
  '                                ::::                            ',
  '                            ::::::::::                          ',
  '                          ::::::::::::::                        ',
  '                        ::::::::::::::::::                      ',
  '                      ::::::::::::::::::::                      ',
  '                  ::::::::::::::::::::::::::                    ',
  '                ::::::::::::::::::::::::::::                    ',
  '              ################################                  ',
  '            ##::##############################++++              ',
  '          ####::::##############################++++++          ',
  '          ####::::::############################++++++++        ',
  '        ######::::::::############################++++++++      ',
  '      ########::::::::::##########################++++++++++    ',
  '    ##########::::::::::::##########################++++++++++  ',
  '  ############::::::::::::::########################++++++++++++',
  '  ############::::::::::::::::########################++++++++++',
  '##############::::::::::::::::::######################++++++++++',
  '##############::::::::::::::::::::######################++++++++',
  '  ############::::::::::::::::::::::####################++++++++',
  '    ##########::::::::::::::::::::::::####################++++++',
  '      ########::::::::::::::::::::::::::##################++++++',
  '          ####::::::::::::::::::::::::::::##################++++',
  '              ::::::::::::::::::::::::::::::################++++',
  '                ..::::::::::::::::::::::::::::############++++++',
  '                ......::::::::::::::::::::::::::##########++++++',
  '                  ........::::::::::::::::::::::::######++++++  ',
  '                  ............::::::::::::::::::::::####++      ',
  '                    ..............::::::::::::::::::::          ',
  '                      ................::::::::::::....          ',
  '                        ..................::::......            ',
  '                          ..........................            ',
  '                            ......................              '
];
