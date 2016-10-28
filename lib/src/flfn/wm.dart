// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

class WindowManager {
  final windows = new List<fl.Window>();

  WindowManager();

  // Apply new configuration
  void reconfigure() {
    // Iterate through existing windows.
    for (final window in windows) {
      // Remove all widgets.

      // Reposition window.

      // Add all widgets.
    }

    // Remove extra windows.
  }
}
