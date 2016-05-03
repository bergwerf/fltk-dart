// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of fltk;

// Fl_Labeltype
enum Labeltype {
  FL_NORMAL_LABEL,
  FL_NO_LABEL,
  // ignore: UNUSED_FIELD
  _FL_SHADOW_LABEL,
  // ignore: UNUSED_FIELD
  _FL_ENGRAVED_LABEL,
  // ignore: UNUSED_FIELD
  _FL_EMBOSSED_LABEL,
  // ignore: UNUSED_FIELD
  _FL_MULTI_LABEL,
  // ignore: UNUSED_FIELD
  _FL_ICON_LABEL,
  // ignore: UNUSED_FIELD
  _FL_IMAGE_LABEL,
  FL_FREE_LABELTYPE
}

// Quick access constants
const NORMAL_LABEL = Labeltype.FL_NORMAL_LABEL;
const NO_LABEL = Labeltype.FL_NO_LABEL;
const SHADOW_LABEL = Labeltype._FL_SHADOW_LABEL;
const ENGRAVED_LABEL = Labeltype._FL_ENGRAVED_LABEL;
const EMBOSSED_LABEL = Labeltype._FL_EMBOSSED_LABEL;
