// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "../gen/classes/Menu.hpp"

namespace fldart {
void _menu_callback(Fl_Widget*, void *data) {
  Dart_PersistentHandle closure = (Dart_PersistentHandle)data;
  Dart_InvokeClosure(closure, 0, {});
}

void Menu::void_add(Dart_NativeArguments arguments) {
  // Local variables
  intptr_t ptr;
  Fl_Menu_ *_ref;
  const char *label;
  int64_t shortcut = 0;
  int64_t flags = 0;

  Dart_EnterScope();

  // Create pointer to FLTK object.
  HandleError(Dart_GetNativeInstanceField(HandleError(Dart_GetNativeArgument(arguments, 0)), 0, &ptr));
  _ref = (Fl_Menu_*)ptr;

  // Get arguments.
  Dart_Handle _label = HandleError(Dart_GetNativeArgument(arguments, 1));
  Dart_Handle _shortcut = HandleError(Dart_GetNativeArgument(arguments, 2));
  Dart_Handle _callback = HandleError(Dart_GetNativeArgument(arguments, 3));
  Dart_Handle _flags = HandleError(Dart_GetNativeArgument(arguments, 4));

  HandleError(Dart_StringToCString(_label, &label));
  HandleError(Dart_IntegerToInt64(_shortcut, &shortcut));
  HandleError(Dart_IntegerToInt64(_flags, &flags));

  // Add callback if a callback reference is passed.
  if (!Dart_IsNull(_callback)) {
    Dart_PersistentHandle handle = Dart_NewPersistentHandle(_callback);
    _ref -> add(label, shortcut, _menu_callback, handle, flags);
  } else {
    _ref -> add(label, shortcut, NULL, NULL, flags);
  }

  // Return
  Dart_Handle _ret = Dart_Null();
  Dart_SetReturnValue(arguments, _ret);
  Dart_ExitScope();
}
}
