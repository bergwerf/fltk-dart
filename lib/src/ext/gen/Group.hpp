#ifndef FLDART_GROUP_H
#define FLDART_GROUP_H

#include <FL/Fl.H>
#include <FL/Fl_Group.H>

#include "dart_api.h"
#include "../common.hpp"

namespace fldart {
  // Dart bindings for Fl_Group
  class Group {
  public:
    static void createGroup(Dart_NativeArguments arguments);
    static void end(Dart_NativeArguments arguments);

    // Method mapping
    static FunctionMapping methods[];
  };
}

#endif
