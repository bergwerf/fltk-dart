// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

/// Fl_When
///
/// Since Dart does not support custom indices in an enumeration, we use const
/// values.

/// Never call the callback.
const WHEN_NEVER = 0;

/// Do the callback only when the widget value changes.
const WHEN_CHANGED = 1;

/// Do the callback whenever the user interacts with the widget.
const WHEN_NOT_CHANGED = 2;

/// Do the callback when the button or key is released and the value changes.
const WHEN_RELEASE = 4;

/// Do the callback when the button or key is released, even if the value
/// doesn't change.
const WHEN_RELEASE_ALWAYS = 6;

/// Do the callback when the user presses the ENTER key and the value changes.
const WHEN_ENTER_KEY = 8;

/// Do the callback when the user presses the ENTER key, even if the value
/// doesn't change.
const WHEN_ENTER_KEY_ALWAYS = 10;

/// Undocumented in FLTK
const WHEN_ENTER_KEY_CHANGED = 11;
