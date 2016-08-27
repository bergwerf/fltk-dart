// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include <FL/Fl_RGB_Image.H>

#include "../gen/classes/Widget.hpp"

namespace fldart {
typedef Fl_Text_Display::Style_Table_Entry StyleEntry;

void TextDisplay::void_highlight_data(Dart_NativeArguments arguments) {
  // Local variables
  intptr_t ptr, bufferPtr;
  Fl_Text_Display_Wrapper *_ref;
  Fl_Text_Buffer *buffer;
  StyleEntry *styletable;

  Dart_EnterScope();

  // Create pointer to FLTK object.
  _ref = (Fl_Text_Display_Wrapper*)getptr(arguments, 0);

  // Get text buffer.
  buffer = (Fl_Text_Buffer*)getptr(arguments, 1);

  // Get styletable.
  Dart_Handle list = HandleError(Dart_GetNativeArgument(arguments, 2));
  int64_t length;
  HandleError(Dart_ListLength(list, &length));
  styletable = (StyleEntry*)malloc(sizeof(StyleEntry) * length);
  for (int64_t i = 0; i < length; i++) {
    Dart_Handle element = HandleError(Dart_ListGetAt(list, i));

    int64_t color, font, size;
    HandleError(Dart_IntegerToInt64(getfield(element, "color"), &color));
    HandleError(Dart_IntegerToInt64(getfield(element, "font"), &font));
    HandleError(Dart_IntegerToInt64(getfield(element, "size"), &size));

    styletable[i] = StyleEntry({
      (Fl_Color)color,
      (Fl_Font)font,
      (Fl_Fontsize)size
    });
  }

  _ref -> highlight_data(buffer, styletable, length, 0, 0, 0);

  // Return
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
