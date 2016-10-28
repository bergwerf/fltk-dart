// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

class Window {
  final int w, h;
  final String l;
  final Map<String, Widget> children;
  fl.DoubleWindow _window;
  Window(this.w, this.h, this.l, {this.children: const {}});

  void build() {
    _window = new fl.DoubleWindow(w, h, l);
    for (final child in children.values) {
      child.build();
    }
    _window.end();
    _window.show();
  }

  void merge(Window other) {
    _window.label = other.l;
  }
}
