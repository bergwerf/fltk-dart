// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

// Fl_Align constants

/// Align the label horizontally in the middle.
const ALIGN_CENTER = 0;

/// Align the label at the top of the widget.
const ALIGN_TOP = 1;

/// Align the label at the bottom of the widget.
const ALIGN_BOTTOM = 2;

/// Align the label at the left of the widget.
const ALIGN_LEFT = 4;

/// Align the label to the right of the widget.
const ALIGN_RIGHT = 8;

/// Draw the label inside of the widget.
const ALIGN_INSIDE = 16;

/// If the label contains an image, draw the text on top of the image.
const ALIGN_TEXT_OVER_IMAGE = 0x0020;

/// If the label contains an image, draw the text below the image.
const ALIGN_IMAGE_OVER_TEXT = 0x0000;

/// All parts of the label that are lager than the widget will not be drawn.
const ALIGN_CLIP = 64;

/// Wrap text that does not fit the width of the widget.
const ALIGN_WRAP = 128;

/// If the label contains an image, draw the text to the right of the image.
const ALIGN_IMAGE_NEXT_TO_TEXT = 0x0100;

/// If the label contains an image, draw the text to the left of the image.
const ALIGN_TEXT_NEXT_TO_IMAGE = 0x0120;

/// If the label contains an image, draw the image or deimage in the background.
const ALIGN_IMAGE_BACKDROP = 0x0200;

const ALIGN_TOP_LEFT = ALIGN_TOP | ALIGN_LEFT;
const ALIGN_TOP_RIGHT = ALIGN_TOP | ALIGN_RIGHT;
const ALIGN_BOTTOM_LEFT = ALIGN_BOTTOM | ALIGN_LEFT;
const ALIGN_BOTTOM_RIGHT = ALIGN_BOTTOM | ALIGN_RIGHT;
const ALIGN_LEFT_TOP = 0x0007;
const ALIGN_RIGHT_TOP = 0x000b;
const ALIGN_LEFT_BOTTOM = 0x000d;
const ALIGN_RIGHT_BOTTOM = 0x000e;
const ALIGN_NOWRAP = 0;
const ALIGN_POSITION_MASK = 0x000f;
const ALIGN_IMAGE_MASK = 0x0320;
