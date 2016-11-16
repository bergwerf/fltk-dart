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

  void build(App app) {
    _window = new fl.DoubleWindow(w, h, l);
    for (final child in children.values) {
      child.build(app);
    }
    _window.end();
    _window.show();
  }

  void merge(Window other, App parent) {
    _window.label = other.l;

    // TODO: hot rescale

    for (final key in other.children.keys) {
      if (children.containsKey(key)) {
        children[key].merge(other.children[key], parent);
      } else {
        children[key] = other.children[key];
        children[key].build(parent);
      }
    }

    for (final key in children.keys) {
      if (!other.children.containsKey(key)) {
        //children[key].destroy();
        children.remove(key);
      }
    }
  }

  Button getButton(List<String> selector) {
    if (children.containsKey(selector.first)) {
      return children[selector.first] as Button;
    } else {
      return null;
    }
  }
}
