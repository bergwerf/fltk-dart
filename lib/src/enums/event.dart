// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Event
enum Event {
  /// No event
  NO_EVENT,

  /// A mouse button has gone down with the mouse pointing at this widget.
  /// You can find out what button by calling [eventButton]. You find out the
  /// mouse position by calling [eventX] and [eventY].
  ///
  /// A widget indicates that it "wants" the mouse click by returning true from
  /// its [Widget.handle] method. It will then become the [pushed] widget and
  /// will get [DRAG] and the matching [RELEASE] events. If [Widget.handle]
  /// returns zero then FLTK will try sending the [PUSH] to another widget.
  PUSH,

  /// A mouse button has been released. You can find out what button by calling
  /// [eventButton]. In order to receive the [RELEASE] event, the widget must
  /// return true when handling [PUSH].
  RELEASE,

  /// The mouse has been moved to point at this widget. This can be used for
  /// highlighting feedback. If a widget wants to highlight or otherwise track
  /// the mouse, it indicates this by returning true from its [Widget.handle]
  /// method. It then becomes the [belowmouse] widget and will receive [MOVE]
  /// and [LEAVE] events.
  ENTER,

  /// The mouse has moved out of the widget. In order to receive the [LEAVE]
  /// event, the widget must return true when handling [ENTER].
  LEAVE,

  /// The mouse has moved with a button held down. The current button state is
  /// in [eventState]. The mouse position is in [eventX] and [eventY]. In order
  /// to receive [DRAG] events, the widget must return true when handling
  /// [PUSH].
  DRAG,

  /// This indicates an attempt to give a widget the keyboard focus. If a widget
  /// wants the focus, it should change itself to display the fact that it has
  /// the focus, and return true from its [Widget.handle] method. It then
  /// becomes the [focus] widget and gets [KEYDOWN], [KEYUP], and [UNFOCUS]
  /// events. The focus will change either because the window manager changed
  /// which window gets the focus, or because the user tried to navigate using
  /// tab, arrows, or other keys. You can check [eventKey] to figure out why it
  /// moved. For navigation it will be the key pressed and for interaction with
  /// the window manager it will be zero.
  FOCUS,

  /// This event is sent to the previous [focus] widget when another widget gets
  /// the focus or the window loses focus.
  UNFOCUS,

  /// A key was pressed ([KEYDOWN]) or released ([KEYUP]). To receive [KEYDOWN]
  /// events you must also respond to the [FOCUS] and [UNFOCUS] events.
  ///
  /// The key can be found in [eventKey]. The text that the key should insert
  /// can be found with [eventText]. If you use the key [Widget.handle] should
  /// return true. If you return zero then FLTK assumes you ignored the key and
  /// will then attempt to send it to a parent widget. If none of them want it,
  /// it will change the event into a [SHORTCUT] event.
  ///
  /// If you are writing a text-editing widget you may also want to call the
  /// [compose] function to translate individual keystrokes into non-ASCII
  /// characters.
  ///
  /// [KEYUP] events are sent to the widget that currently has focus. This is
  /// not necessarily the same widget that received the corresponding [KEYDOWN]
  /// event because focus may have changed between events.
  KEYDOWN,

  /// Not included because it messes up the enumeration values.
  ///KEYBOARD,

  /// Key release event.
  KEYUP,

  /// The user clicked the close button of a window. This event is used
  /// internally only to trigger the callback of Window derived classed. The
  /// default callback closes the window calling [Window.hide].
  CLOSE,

  /// The mouse has moved without any mouse buttons held down. This event is
  /// sent to the [belowmouse] widget. In order to receive [MOVE] events, the
  /// widget must return true when handling [ENTER].
  MOVE,

  /// If the [focus] widget is null or ignores a [KEYBOARD] event then FLTK
  /// tries sending this event to every widget it can, until one of them returns
  /// true.
  ///
  /// SHORTCUT is first sent to the [belowmouse] widget, then its parents and
  /// siblings, and eventually to every widget in the window, trying to find an
  /// object that returns true. FLTK tries really hard to not to ignore any
  /// keystrokes!
  ///
  /// You can also make global shortcuts by using [addHandler]. A global
  /// shortcut will work no matter what windows are displayed or which one has
  /// the focus.
  SHORTCUT,

  /// This widget is no longer active, due to [Widget.deactivate] being called
  /// on it or one of its parents. [Widget.active] may still be true after this,
  /// the widget is only active if [Widget.active] is true on it and all its
  /// parents (use [Widget.activeR] to check this).
  DEACTIVATE,

  /// This widget is now active, due to [Widget.activate] being called on it or
  /// one of its parents.
  ACTIVATE,

  /// This widget is no longer visible, due to [Widget.hide] being called on it
  /// or one of its parents, or due to a parent window being minimized.
  /// [Widget.visible] may still be true after this, but the widget is visible
  /// only if [Widget.visible] is true for it and all its parents (use
  /// [Widget.visibleR] to check this).
  HIDE,

  /// This widget is visible again, due to [Widget.show] being called on it or
  /// one of its parents, or due to a parent window being restored.
  ///
  /// Child windows respond to this by actually creating the window if not done
  /// already, so if you subclass a window, be sure to pass [SHOW] to the base
  /// class [Widget.handle] method!
  SHOW,

  /// You should get this event some time after you call [paste]. The contents
  /// of [eventText] is the text to insert.
  PASTE,

  /// The [selectionOwner] will get this event before the selection is moved
  /// to another widget.
  ///
  /// This indicates that some other widget or program has claimed the
  /// selection. Motif programs used this to clear the selection indication.
  /// Most modern programs ignore this.
  SELECTIONCLEAR,

  /// The user has moved the mouse wheel. The [eventDx] and [eventDy] getters
  /// can be used to find the amount to scroll horizontally and vertically.
  MOUSEWHEEL,

  /// The mouse has been moved to point at this widget. A widget that is
  /// interested in receiving Drag And Drop data must return true to receive
  /// [DND_DRAG], [DND_LEAVE] and [DND_RELEASE] events.
  DND_ENTER,

  /// The mouse has been moved inside a widget while dragging data. A widget
  /// that is interested in receiving Drag And Drop data should indicate the
  /// possible drop position.
  DND_DRAG,

  /// The mouse has moved out of the widget.
  DND_LEAVE,

  /// The user has released the mouse button dropping data into the widget. If
  /// the widget returns true, it will receive the data in the immediately
  /// following [PASTE] event.
  DND_RELEASE,

  /// The screen configuration (number, positions) was changed. Use [addHandler]
  /// to be notified of this event.
  SCREEN_CONFIGURATION_CHANGED,

  /// The fullscreen state of the window has changed.
  FULLSCREEN
}
