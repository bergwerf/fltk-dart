// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:fltk/fltk.dart' as fl;

class Sender extends fl.Box {
  Sender(int x, int y, int w, int h) : super(x, y, w, h) {
    box = fl.FLAT_BOX;
    color = fl.GREEN;
    label = 'Drag from\nhere';
  }

  bool handle(fl.Event event) {
    switch (event) {
      case fl.Event.PUSH:
        fl.copy('message');
        fl.dnd();
        return true;

      default:
        return false;
    }
  }
}

class Receiver extends fl.Box {
  Receiver(int x, int y, int w, int h) : super(x, y, w, h) {
    box = fl.FLAT_BOX;
    color = fl.RED;
    label = 'to here';
  }

  bool handle(fl.Event event) {
    switch (event) {
      case fl.Event.DND_ENTER:
      case fl.Event.DND_DRAG:
      case fl.Event.DND_RELEASE:
        // Return true for these events to 'accept' dnd.
        return true;

      case fl.Event.PASTE:
        // Handle actual drop (paste) operation.
        label = fl.eventText;
        return true;

      default:
        return false;
    }
  }
}

int main() {
  // Create sender window and widget.
  final winA = new fl.Window.at(0, 0, 200, 100, 'Sender');
  new Sender(0, 0, 100, 100);
  winA.end();
  winA.show();

  // Create receiver window and widget.
  final winB = new fl.Window.at(400, 0, 200, 100, 'Receiver');
  new Receiver(100, 0, 100, 100);
  winB.end();
  winB.show();

  return fl.run();
}
