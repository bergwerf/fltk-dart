#ifndef FLDART_BOX_H
#define FLDART_BOX_H

#include <FL/Fl.H>
#include <FL/Fl_Box.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
  // Dart bindings for Fl_Box
  class Box {
  public:
    static void createBox(Dart_NativeArguments arguments);

    // Method mapping
    static FunctionMapping methods[];
  };
}

#endif
