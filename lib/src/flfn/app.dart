// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

class App {
  final Map<String, Window> windows;
  final String scheme;
  App({this.windows: const {}, this.scheme: ''});

  /// Build actual widgets.
  void build() {
    fl.scheme = scheme;
    for (final window in windows.values) {
      window.build(this);
    }
  }

  void merge(App other) {
    fl.scheme = other.scheme;
    for (final key in other.windows.keys) {
      if (windows.containsKey(key)) {
        windows[key].merge(other.windows[key]);
      } else {
        windows[key] = other.windows[key];
        windows[key].build(this);
      }
    }

    for (final key in windows.keys) {
      if (!other.windows.containsKey(key)) {
        //windows[key].destroy();
        windows.remove(key);
      }
    }
  }

  Button getButton(String id) {
    final selector = id.split('/');
    if (windows.containsKey(selector.first)) {
      return windows[selector.first].getButton(selector.sublist(1));
    } else {
      return null;
    }
  }
}
