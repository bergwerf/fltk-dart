// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <string.h>
#include <iostream>
#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Button.H>

void button_cb(Fl_Widget *obj, void*) {
  obj -> label(strcmp("OFF", obj -> label()) ? "OFF" : "ON");
}

int main(int argc, char *argv[]) {
  Fl::scheme("gleam");
  auto window = new Fl_Window(300, 200, "Click the button...");
  auto button = new Fl_Button(0, 0, window -> w(), window -> h(), "ON");
  button -> callback((Fl_Callback*)button_cb);
  window -> end();
  window -> show();
  return Fl::run();
}
