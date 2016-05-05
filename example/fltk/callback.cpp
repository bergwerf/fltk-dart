// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <string.h>
#include <iostream>
#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Button.H>

void button_cb(Fl_Widget* obj, void*) {
  obj -> label(strcmp("OFF", obj -> label()) ? "OFF" : "ON");
}

int main( int argc, char* argv[] ) {
  Fl::scheme("gleam");
  Fl_Window* win = new Fl_Window(300, 200, "Click the button...");
  Fl_Button* but = new Fl_Button(0, 0, win -> w(), win -> h(), "ON");
  but -> callback((Fl_Callback*)button_cb);
  win -> end();
  win -> show();
  return Fl::run();
}
