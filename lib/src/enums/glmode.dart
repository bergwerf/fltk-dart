// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

// Fl_Mode constants

/// RGB color (not indexed)
const FL_RGB = 0;

/// Indexed mode
const FL_INDEX = 1;

/// Not double buffered
const FL_SINGLE = 0;

/// Double buffered
const FL_DOUBLE = 2;

/// Accumulation buffer
const FL_ACCUM = 4;

/// Alpha channel in color
const FL_ALPHA = 8;

/// Depth buffer
const FL_DEPTH = 16;

/// Stencil buffer
const FL_STENCIL = 32;

/// RGB color with at least 8 bits of each color
const FL_RGB8 = 64;

/// Multisample antialiasing
const FL_MULTISAMPLE = 128;

/// Undocumented in FLTK
const FL_STEREO = 256;

/// Undocumented in FLTK
const FL_FAKE_SINGLE = 512;
