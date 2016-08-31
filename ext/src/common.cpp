// Copyright (c) 2016, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

#include "common.hpp"

namespace fldart {
Dart_Handle HandleError(Dart_Handle handle) {
  if (Dart_IsError(handle)) {
    Dart_PropagateError(handle);
  } else {
    return handle;
  }
}

const char* newstr(const char *src) {
  if (strlen(src) > 0) {
    return strcpy(new char[strlen(src) + 1], src);
  } else {
    return nullptr;
  }
}

Dart_Handle getarg(Dart_NativeArguments arguments, int n) {
  return HandleError(Dart_GetNativeArgument(arguments, n));
}

Dart_Handle getfield(Dart_Handle container, const char *name) {
  HandleError(Dart_GetField(container, Dart_NewStringFromCString(name)));
}

intptr_t getptr(Dart_NativeArguments arguments, int argn) {
  intptr_t dst;
  HandleError(
    Dart_GetNativeInstanceField(
      HandleError(
        Dart_GetNativeArgument(arguments, argn)), 0, &dst));
  return dst;
}

uint8_t *getUint8List(Dart_NativeArguments arguments, int argn) {
  void *data;
  Dart_Handle handle = getarg(arguments, argn);

  int64_t length;
  HandleError(Dart_ListLength(handle, &length));

  // Aquire data.
  Dart_TypedData_Type type = Dart_TypedData_kUint8;
  HandleError(Dart_TypedDataAcquireData(handle, &type, &data, &length));

  // Reallocate to create safe memory block.
  uint8_t *byteData = (uint8_t*)malloc(length);
  memcpy(byteData, data, length);

  // Release data.
  HandleError(Dart_TypedDataReleaseData(handle));

  return byteData;
}
}
