// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library fltk;

import 'dart-ext:fldart';

import 'dart:nativewrappers';
import 'dart:typed_data';
import 'dart:async';

import 'package:color/color.dart';
import 'package:image/image.dart' hide Color;
import 'package:cairodart/cairodart.dart' as cairo;

import 'src/utils/cairo.dart';

import 'enums.dart';
export 'enums.dart';

part 'src/fl/core.dart';
part 'src/fl/draw.dart';
part 'src/fl/color.dart';
part 'src/fl/event.dart';
part 'src/fl/xpm.dart';

part 'src/widget.dart';
part 'src/group.dart';
part 'src/box.dart';
part 'src/button.dart';
part 'src/input.dart';
part 'src/menu.dart';
part 'src/choice.dart';
part 'src/text_buffer.dart';
part 'src/text_display.dart';
part 'src/text_editor.dart';
part 'src/window.dart';
part 'src/double_window.dart';
part 'src/gl_window.dart';
part 'src/cairo_window.dart';
part 'src/cairo_surface.dart';
