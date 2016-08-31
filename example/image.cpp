// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl.H>
#include <FL/Fl_Box.H>
#include <FL/Fl_PNG_Image.H>
#include <FL/Fl_Double_Window.H>

int main() {
  // Using a single buffered window gives issues with image alpha rendering.
  auto window = new Fl_Double_Window(64,64);

  // There is a difference between an empty string and a nullptr label. When you
  // use an empty string, FLTK will move the image 8 pixels up.
  //auto box = new Fl_Box(0, 0, 64, 64, "");
  auto box = new Fl_Box(0, 0, 64, 64, nullptr);

  auto png = new Fl_PNG_Image("example/image.png");
  box -> image(png);
  window -> end();
  window -> show();
  return Fl::run();
}
