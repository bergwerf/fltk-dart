// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Calls [wait] in a loop until the return value is 0.
int run() native 'fldart::run';

/// Runs FLTK asynchronously (using some black magic).
/// TODO: try to implement this using isolates and sendports for callbacks?
Future runAsync() {
  var completer = new Completer();
  Function cycle;
  cycle = () {
    int state = check();
    if (state == 0) {
      completer.complete();
    } else {
      new Future.microtask(cycle);
    }
  };

  new Future.microtask(cycle);
  return completer.future;
}

/// Handle pending events and update interface.
/// Same as `Fl::wait(0);` in FLTK.
int check() native 'fldart::check';

/// Waits for the next event. Returns 0 if all windows are closed.
int wait() native 'fldart::wait';

/// Set the FLTK widget theme.
///
/// You can choose from:
///
/// - `none`: This is the default scheme and resembles old Windows
///    (95/98/Me/NT/2000) and old GTK/KDE.
/// - `base`: This is an alias for none.
/// - `gtk+`: This scheme is inspired by the Red Hat Bluecurve theme.
/// - `gleam`: This scheme is inspired by the Clearlooks Glossy scheme.
/// - `plastic`: This scheme is inspired by the Aqua user interface on Mac OS X.
int scheme(String name) native 'fldart::scheme';

/// Color utility function
int rgbColor(int r, [int g = -1, int b = -1]) {
  // if g and b are -1, use r as grayscale.
  if (g + b == -2) {
    return rgbColor(r, r, r);
  } else {
    return r << 24 & 0xff000000 | g << 16 & 0xff0000 | b << 8 & 0xff00;
  }
}
