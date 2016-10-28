// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk.flfn;

class Button extends Widget {
  final int x, y, w, h, labelsize, labelfont, labelcolor, color;
  final String l;
  final fl.Boxtype box;
  final fl.Labeltype labeltype;
  fl.Button _button;

  Button(this.x, this.y, this.w, this.h, this.l,
      {this.box: fl.NO_BOX,
      this.labelsize: 16,
      this.labelfont: 0,
      this.labeltype: fl.NORMAL_LABEL,
      this.labelcolor: fl.BLACK,
      Color color: const RgbColor(255, 255, 255)})
      : color = fl.toColor(color);

  void build() {
    _button = new fl.Button(x, y, w, h, l);
    _button
      ..labelsize = labelsize
      ..labelfont = labelfont
      ..labelcolor = labelcolor
      ..color = color
      ..box = box
      ..labeltype = labeltype;
  }
}
