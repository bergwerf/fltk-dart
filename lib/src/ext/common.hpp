#ifndef FLDART_COMMON_H
#define FLDART_COMMON_H

#include "dart_api.h"

namespace fldart {
  struct FunctionMapping {
    const char* name;
    Dart_NativeFunction function;
  };
}

#endif
