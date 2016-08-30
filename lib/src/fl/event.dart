// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Initiate a Drag And Drop operation.
void dnd() native 'fldart::dnd';

/// Destination for [copy].
enum CopyDestination { selectionBuffer, clipboard }

void _copy(String data, int length, int destination, String mime)
    native 'fldart::copy';

/// Copy [data] with the given [mime] type, into the [destination].
void copy(String data,
        {String mime: 'text/plain',
        CopyDestination destination: CopyDestination.selectionBuffer}) =>
    _copy(data, data.length, destination.index, mime);

/// Get current mouse x position.
int get eventX native 'fldart::event_x';

/// Get current mouse y position.
int get eventY native 'fldart::event_y';

/// Get horizontal scroll ammount (right is positive).
int get eventDx native 'fldart::event_dx';

/// Get vertical scroll ammount (down is positive).
int get eventDy native 'fldart::event_dy';

/// Get key code of the key that was last pressed.
int get eventKey native 'fldart::event_key';

/// Get the text associated with the current event.
String get eventText native 'fldart::event_text';

/// Bitfield to check what special keys or mouse buttons were pressed in the
/// most recent event.
int get eventState native 'fldart::event_state';

/// Get which mouse button caused the current event in case of an [Event.PUSH]
/// or [Event.RELEASE].
int get eventButton native 'fldart::event_button';

/// Wrapper class for all event data.
class EventData {
  final int x, y, dx, dy, key, state, button;
  final String text;

  EventData(this.x, this.y, this.dx, this.dy, this.key, this.state, this.button,
      this.text);

  /// Create instance from the current event data.
  factory EventData.current() => new EventData(eventX, eventY, eventDx, eventDy,
      eventKey, eventState, eventButton, eventText);
}

/// Get current event data.
EventData get currentEvent => new EventData.current();
