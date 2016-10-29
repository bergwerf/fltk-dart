// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

typedef dynamic Callback<T>(App app, T widget);

abstract class Widget<W extends fl.Widget> {
  final Map<String, dynamic> _props;
  W _widget;

  Widget(this._props);

  void build(App app) {
    _widget = _createInstance();
    applyProps(app);

    // When a widget is built from scratch all state is discarded.
    _props.clear();
  }

  W _createInstance();

  String get label => _widget.label;

  set label(String label) {
    _props['label'] = label;
    _widget.label = label;
  }

  void unset(String prop) => _props.remove(prop);

  void mergeProps(Map<String, dynamic> others) {
    // I'm not sure if Map.addAll overwrites.
    for (final key in others.keys) {
      _props[key] = others[key];
    }
  }

  void applyProps(App app) {
    if (_props.containsKey('labelsize')) {
      _widget.labelsize = _props['labelsize'];
    }
    if (_props.containsKey('labelfont')) {
      _widget.labelfont = _props['labelfont'];
    }
    if (_props.containsKey('labelcolor')) {
      _widget.labelcolor = _props['labelcolor'];
    }
    if (_props.containsKey('labeltype')) {
      _widget.labeltype = _props['labeltype'];
    }
    if (_props.containsKey('color')) {
      _widget.color = _props['color'];
    }
    if (_props.containsKey('box')) {
      _widget.box = _props['box'];
    }
    if (_props.containsKey('callback')) {
      final callback = _props['callback'] as Callback;
      _widget.callback = (a, b) {
        callback(app, this);
      };
    }
  }
}
