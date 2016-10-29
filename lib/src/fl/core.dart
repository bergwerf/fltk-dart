// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Switch to use synchronous streams everywhere
bool useSyncStreams = false;

/// (Timer time) => void function
typedef void _PeriodicTimerCallback(Timer timer);

/// Run FLTK synchronously
///
/// Calls [wait] in a loop until the return value is 0.
int run() native 'fldart::run';

/// Runs FLTK asynchronously (using some black magic)
///
/// It is important to use [Timer.run] instead of [scheduleMicrotask] so Timer
/// events are not blocked.
Future<int> runAsync([Duration interval = Duration.ZERO]) {
  final completer = new Completer<int>();
  _PeriodicTimerCallback cycle;
  cycle = (Timer timer) {
    final state = check();
    if (state == 0) {
      timer.cancel();
      completer.complete(state);
    }
  };

  new Timer.periodic(interval, cycle);
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
set scheme(String name) native 'fldart::scheme';

void _option(int option, bool value) native 'fldart::option';

/// Set option value.
void option(Option option, bool value) => _option(option.index, value);
