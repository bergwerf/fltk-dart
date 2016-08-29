// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

// Based on: http://seriss.com/people/erco/fltk/#DragAndDrop

#include <map>
#include <stdio.h>
#include <FL/Fl.H>
#include <FL/Fl_Window.H>
#include <FL/Fl_Box.H>

class Sender : public Fl_Box {
 public:
  Sender(int x, int y, int w, int h) : Fl_Box(x, y, w, h) {
    box(FL_FLAT_BOX);
    color(FL_GREEN);
    label("Drag from\nhere");
  }

  int handle(int event) {
    int ret = Fl_Box::handle(event);

    switch (event) {
    case FL_PUSH:
      Fl::copy("message", 7, 0);
      Fl::dnd();
      return 1;
    }

    return ret;
  }
};

class Receiver : public Fl_Box {
 public:
  Receiver(int x,int y,int w,int h) : Fl_Box(x,y,w,h) {
    box(FL_FLAT_BOX);
    color(FL_RED);
    label("to here");
  }

  int handle(int event) {
    int ret = Fl_Box::handle(event);

    switch (event) {
    case FL_DND_ENTER:
    case FL_DND_DRAG:
    case FL_DND_RELEASE:
      // return 1 for these events to 'accept' dnd
      return 1;

    case FL_PASTE:
      // handle actual drop (paste) operation
      label(Fl::event_text());
      return 1;
    }

    return ret;
  }
};

int main(int argc, char **argv) {
  // Create sender window and widget.
  auto win_a = new Fl_Window(0, 0, 200, 100, "Sender");
  auto a = new Sender(0, 0, 100, 100);
  win_a -> end();
  win_a -> show();

  // Create receiver window and widget.
  auto win_b = new Fl_Window(400, 0, 200, 100, "Receiver");
  auto b = new Receiver(100, 0, 100, 100);
  win_b -> end();
  win_b -> show();

  return Fl::run();
}
