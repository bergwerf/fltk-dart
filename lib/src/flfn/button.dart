// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

class Button extends Widget<fl.Button> {
  Button(int x, int y, int w, int h,
      {String label: '',
      int labelsize: 16,
      int labelfont: 0,
      int labelcolor: fl.BLACK,
      fl.Boxtype box: fl.NO_BOX,
      fl.Labeltype labeltype: fl.NORMAL_LABEL,
      Color color: const RgbColor(255, 255, 255),
      Callback<Button> callback: null})
      : super({
          'x': x,
          'y': y,
          'w': w,
          'h': h,
          'label': label,
          'labelsize': labelsize,
          'labelfont': labelfont,
          'labelcolor': labelcolor,
          'labeltype': labeltype,
          'box': box,
          'color': fl.toColor(color),
          'callback': callback
        });

  fl.Button _createInstance() => new fl.Button(
      _props['x'], _props['y'], _props['w'], _props['h'], _props['label']);
}
